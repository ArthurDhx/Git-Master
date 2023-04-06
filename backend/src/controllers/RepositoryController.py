from flask_jwt_extended import jwt_required, get_jwt_identity
from flask import request, current_app
from src.responses.response_models import Ok, BadRequest
from src.database.dals.student_dal import StudentDAL
from src.database.models.repo_group import RepoGroup
from src.database.models.student_repo_group import StudentRepoGroup
from src.database.dals.repo_group_dal import RepoGroupDAL
from src.database.dals.pupil_group_dal import PupilGroupDAL
from src.database.dals.repo_group_filter_dal import RepoGroupFilterDAL
from src.services.gitLabServices import createProject, inviteStudentToProject, inviteTeacherToRepoGroup, removeMemberFromRepoGroup, removeMemberFromProject
from src.database.dals.user_dal import UserDAL
from src.database.models.repo_group_filters import RepoFilters
from src.scheduler import scheduler
from apscheduler.triggers.date import DateTrigger
import uuid

from datetime import datetime

@jwt_required()
def create_repo_group(repo_group_dal = RepoGroupDAL(), pupil_group_dal = PupilGroupDAL(), student_dal = StudentDAL(), user_dal=UserDAL()):
    # Get id_creator
    id_creator = get_jwt_identity()
    
    # Get data from form
    post_data = request.get_json()
    name = post_data.get('name')
    id_repo = post_data.get('id')
    start_date = post_data.get('start_date')
    end_date = post_data.get('end_date')
    studentsGroup = post_data.get('studentsGroup')
    pupilsGroups = post_data.get('pupilsGroups')
    teachersList = post_data.get('teachers')
    studentsList = post_data.get('students')

    # Create new repoGroup
    repoGroup = RepoGroup(id_repo, name, start_date, end_date, id_creator)
    repo_group_dal.add(repoGroup)

    # Add group for creator in db
    _, creator = user_dal.get_by_id(id_creator)
    user_dal.add_repo_group(creator,repoGroup)

    # Add Students
    if not studentsGroup:
        for id_pupil_group in pupilsGroups:
            # get all students from a pupil group
            _, students = pupil_group_dal.get_students_by_id(id_pupil_group)
            studentsId = list(map(lambda s: s.id, students))
            studentsList = list(set(studentsList+studentsId))
            
        # Invite students
        if len(studentsList):
            for student_id in studentsList :
                _, student= student_dal.get_by_id(student_id)
                id_project = createProject(id_repo, name + '_' + student.uid_ul)
                repo_group_dal.add_project(repoGroup, StudentRepoGroup(id_repo, student.id, id_project))
                inviteStudentToProject(student.email, id_project)
        
        # Invite teachers
        if len(teachersList):
            for teacher_id in teachersList:
                _, user = user_dal.get_by_id(teacher_id)
                user_dal.add_repo_group(user,repoGroup)
                inviteTeacherToRepoGroup(user.email, id_repo)
    else:
        for index, group in enumerate(studentsGroup, start=0):
            if group:
                id_project = createProject(id_repo, name + '_' + str(index))
                for student in group:
                    repo_group_dal.add_project(repoGroup, StudentRepoGroup(id_repo, student['value'], id_project))
                    inviteStudentToProject(student['email'], id_project)

    # Vérification date d'ouverture
    now = datetime.now()

    if(now > repoGroup.start_date):
        repo_group_dal.open_repo_group(repoGroup.id_repo, repoGroup.start_date)
    else:
        scheduler.add_job(id=str(uuid.uuid4()),func=repo_group_dal.open_repo_group, args=[repoGroup.id_repo, repoGroup.start_date], trigger=DateTrigger(run_date=datetime(repoGroup.start_date.year,repoGroup.start_date.month, repoGroup.start_date.day, repoGroup.start_date.hour, repoGroup.start_date.minute, 0)))

    # Vérification date de fermeture
    if(repoGroup.end_date != None):
        if(now >= repoGroup.end_date):
            repoGroup.close_repo_group(repoGroup.id_repo, repoGroup.end_date)
        else:
            scheduler.add_job(id=str(uuid.uuid4()),func=repo_group_dal.close_repo_group, trigger=DateTrigger(run_date=datetime(repoGroup.end_date.year,repoGroup.end_date.month, repoGroup.end_date.day, repoGroup.end_date.hour, repoGroup.end_date.minute, 0)), args=[repoGroup.id_repo, repoGroup.end_date])

    return Ok(message = 'INSERT_OK').toString()

@jwt_required()
def edit_repo_group(id, repo_group_dal = RepoGroupDAL(), user_dal=UserDAL()):
    _, repo_group = repo_group_dal.get_by_id(id)

    # Get data from form
    post_data = request.get_json()
    repo_group.label_group = post_data.get('label_group')
    repo_group.start_date = post_data.get('start_date')
    repo_group.end_date = post_data.get('end_date')
    users = post_data.get('users')
    
    # Save changes
    repo_group_dal.save(repo_group)
    
    users_new = []
    users_old = repo_group.users[:]
    
    for user in users:
        _, user_db = user_dal.get_by_id(user['value'])
        users_new.append(user_db)

    # Remove old users, not member anymore
    for user in users_old:
        if user not in users_new:
            user_dal.remove_repo_group(user, repo_group)
            removeMemberFromRepoGroup(user.email, id, user.id_gitlab)
    
    # Add new users
    for user in users_new:
        if user not in users_old:
            user_dal.add_repo_group(user, repo_group)
            inviteTeacherToRepoGroup(user.email, id)
    
    # Vérification date d'ouverture
    now = datetime.now()

    if(now > repo_group.start_date):
        repo_group_dal.open_repo_group(repo_group.id_repo, repo_group.start_date)
    else:
        scheduler.add_job(id=str(uuid.uuid4()), func=repo_group_dal.open_repo_group, args=[repo_group.id_repo, repo_group.start_date], trigger=DateTrigger(run_date=datetime(repo_group.start_date.year,repo_group.start_date.month, repo_group.start_date.day, repo_group.start_date.hour, repo_group.start_date.minute, 0)))

    if(repo_group.start_date > now and repo_group.is_open):
        repo_group_dal.close_repo_group(repo_group.id_repo, repo_group.end_date)
    
    # Vérification date de fermeture
    if(repo_group.end_date != None):
        if(now >= repo_group.end_date):
            repo_group_dal.close_repo_group(repo_group.id_repo, repo_group.end_date)
        else:
            scheduler.add_job(id=str(uuid.uuid4()), func=repo_group_dal.close_repo_group, args=[repo_group.id_repo, repo_group.end_date], trigger=DateTrigger(run_date=datetime(repo_group.end_date.year,repo_group.end_date.month, repo_group.end_date.day, repo_group.end_date.hour, repo_group.end_date.minute, 0)))


    return Ok(message = 'UPDATE_OK').toString()

@jwt_required()
def delete_repo_group(id, repo_group_dal = RepoGroupDAL()):
    _, repo_group = repo_group_dal.get_by_id(id)

    # Delete repo_group
    repo_group_dal.delete(repo_group)

    return Ok(message = 'DELETE_OK').toString()

@jwt_required()
def get_all_repo_group(repo_group=RepoGroupDAL()):
    (repo_groups, raw_data) = repo_group.get_all()
    return Ok(data = repo_groups).toString()

@jwt_required()
def get_repo_group(id, repo_group = RepoGroupDAL()):
    (repo_group, raw_data) = repo_group.get_by_id(id)
    if not raw_data:
        return BadRequest(message = "NOT FOUND").toString()
    
    return Ok(data = repo_group).toString()

@jwt_required()
def delete_project(id_group, id_project, id_contributor, id_gitlab, repo_group_dal = RepoGroupDAL(), student_dal = StudentDAL()):
    (repo_group, raw_data) = repo_group_dal.get_by_id(id_group)
    (_, student) = student_dal.get_by_id(id_contributor)
    project_to_delete = None
    
    for project in raw_data.projets:
        if int(project.id_project) == int(id_project):
            project_to_delete = project
            break
    
    # Delete project
    if project_to_delete:
        removeMemberFromProject(student.email, id_project, id_gitlab)
        repo_group_dal.delete_project(raw_data, project_to_delete)

    return Ok(message = 'DELETE_OK').toString()

@jwt_required()
def delete_project_contributor(id_group, id_project, id_contributor, id_gitlab, repo_group_dal = RepoGroupDAL(), student_dal = StudentDAL()):
    (repo_group, raw_data) = repo_group_dal.get_by_id(id_group)
    (_, student) = student_dal.get_by_id(id_contributor)
    project = None
    
    for proj in raw_data.projets:
        if int(proj.id_project) == int(id_project):
            project = proj
            break
    
    # Delete project
    if project:
        removeMemberFromProject(student.email, id_project, id_gitlab)
        student_dal.remove_projet(student, project)
        
    return Ok(message = 'DELETE_OK').toString()

        
@jwt_required()
def delete_filter(id_filter, repo_group_filter_dal = RepoGroupFilterDAL()):
    (repo_group, raw_data) = repo_group_filter_dal.get_by_id(id_filter)

    if raw_data:
        repo_group_filter_dal.delete(raw_data)

    return Ok(message = 'DELETE_OK').toString()

@jwt_required()
def add_filter(id, repo_group_filter_dal = RepoGroupFilterDAL()):
    # Get data from form
    post_data = request.get_json()
    file_path = post_data.get('file_path')

    # Creation
    filter = RepoFilters(id, file_path)
    repo_group_filter_dal.add(filter)

    (repo_group, raw_data) = repo_group_filter_dal.get_by_label(file_path)

    return Ok(message = repo_group).toString()