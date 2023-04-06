from flask_jwt_extended import jwt_required, get_jwt_identity
from flask import request
from src.database.models.role import Role
from src.database.models.student import Student
from src.database.models.user import User
from src.database.dals.user_dal import UserDAL
from src.database.dals.student_dal import StudentDAL
from src.database.dals.role_dal import RoleDAL
from src.database.dals.class_group_dal import ClassGroupDAL
from src.database.dals.repo_group_dal import RepoGroupDAL
from src.database.dals.pupil_group_dal import PupilGroupDAL
from src.database.dals.years_dal import YearsDAL
from src.responses.response_models import BadRequest, Ok
from src.services.gitLabServices import deleteRepoGroup, deleteProject

@jwt_required()
def get_all_class_groups(group_dal = ClassGroupDAL()):
    data, raw_data = group_dal.get_all()
    return Ok(data = data).toString()

@jwt_required()
def create_student(student_dal=StudentDAL(),group_dal=ClassGroupDAL(), year_dal=YearsDAL()):
    # Get data from form
    post_data = request.get_json()
    firstname = post_data.get('firstname')
    lastname = post_data.get('lastname')
    email = post_data.get('email')
    uid_ul = post_data.get('uid_ul')
    year = int(post_data.get('year'))
    formation = post_data.get('formation')

    # Check if email is existing
    _, student = student_dal.get_by_email(email)
    if student:
        return BadRequest(message = 'EMAIL_ALREADY_USED').toString()

    # Create new student
    student = Student(firstname, lastname, email, uid_ul, formation)
    student_id = student_dal.add(student)
    
    # Add group
    id_group = post_data.get('group')
    if(id_group != -1):
        if (str(id_group).isnumeric()):
            _, raw_data = group_dal.get_by_id(id_group)
        else :
            _, raw_data = group_dal.get_by_name(id_group)
        student_dal.add_group(student, raw_data)

    # Add year
    _, raw_data = year_dal.get_by_id(year)
    student_dal.add_year(student, raw_data)
    
    return Ok(message = 'INSERT_OK').toString()

@jwt_required()
def edit_student(id, student_dal=StudentDAL(), group_dal=ClassGroupDAL(), year_dal=YearsDAL()):
    _, student = student_dal.get_by_id(id)

    # Get data from form
    post_data = request.get_json()
    student.firstname = post_data.get('firstname')
    student.lastname = post_data.get('lastname')
    student.email = post_data.get('email')
    student.uid_ul = post_data.get('uid_ul')
    year = int(post_data.get('year'))
    student.formation = post_data.get('formation')
    
    # Check if email is existing
    _, otherStudent = student_dal.get_by_email(student.email)
    if otherStudent and otherStudent.id != int(id):
        return BadRequest(message = 'EMAIL_ALREADY_USED').toString()

    # Sauvegarde
    student_dal.save(student)

    # Groupe
    id_group = post_data.get('group')

    list = []
    list.append(id_group)
    
    # Delete group
    for group in student.class_groups:
        if group.id_group not in list:
            _, raw_data = group_dal.get_by_id(group.id_group)
            student_dal.remove_group(student, raw_data)

    # Add Group
    if(id_group != -1):
        _, raw_data = group_dal.get_by_id(id_group)
        student_dal.add_group(student, raw_data)
        
    _, raw_data = year_dal.get_by_id(student.years[0].id_year)
    student_dal.remove_year(student, raw_data)
    
    _, raw_data = year_dal.get_by_id(year)
    student_dal.add_year(student, raw_data)
    
    return Ok(message = 'UPDATE_OK').toString()

@jwt_required()
def delete_student(id, student_dal=StudentDAL(), repo_group_dal = RepoGroupDAL(), pupil_group_dal = PupilGroupDAL(), year_dal=YearsDAL()):
    _, student = student_dal.get_by_id(id)

    if not student:
        BadRequest(message = 'USER_NOT_FOUND').toString()

    # Delete projects, in bd and in gitlab
    for projet in student.projets:
        deleteProject(projet.id_project)        
        student_dal.remove_projet(student, projet)
        _, repo = repo_group_dal.get_by_id(projet.repo.id_repo)
        
        # Delete repo_group if no more projet
        if not repo.projets:
            deleteRepoGroup(repo.id_repo)
            repo_group_dal.delete(repo)
    
    _, raw_data = year_dal.get_by_id(student.years[0].id_year)
    student_dal.remove_year(student, raw_data)
    
    # Delete student
    student_dal.delete(student)

    # Delete student_group if no more students
    for group in student.pupil_groups:
        if not group.students:
            pupil_group_dal.delete(group)
    
    return Ok(message = 'DELETE_OK').toString()


@jwt_required()
def get_all_students(student_dal=StudentDAL()):
    (students, raw_data) = student_dal.get_all()
    return Ok(data = students).toString()

@jwt_required()
def get_student(id, student_dal=StudentDAL()):   
    (student, raw_data) = student_dal.get_by_id(id)
    if not raw_data:
        return BadRequest(message = "NOT FOUND").toString()
    else:
        return Ok(data = student).toString()

@jwt_required()
def create_students(student_dal=StudentDAL(), group_dal=ClassGroupDAL(), year_dal=YearsDAL()):
    
     # Get data from form
    post_data = request.get_json()
    listOfStudentsToAdd = []
    listOfGroupsToAdd = []
    
    for studentData in post_data:
        firstname = studentData[0]
        lastname = studentData[1]
        email = studentData[2]
        uid_ul = studentData[3]
        year = str(studentData[4])
        formation = studentData[5]

        _, year_db = year_dal.get_by_name(year)

        # Check if email is existing
        _, student = student_dal.get_by_email(email)
        if student:
            return BadRequest(message = 'EMAIL_ALREADY_USED', data=email).toString()

        # Create new student
        student = Student(firstname, lastname, email, uid_ul, formation)
        student_dal.add_year(student, year_db)
        
        listOfStudentsToAdd.append(student)
        
        # Add group
        id_group = studentData[6]
        if(id_group != -1):
            if (id_group.isnumeric()):
                _, group = group_dal.get_by_id(id_group)
            else :
                _, group = group_dal.get_by_name(id_group)
            listOfGroupsToAdd.append([student, group])
            
    for studentGroup in listOfGroupsToAdd:
        student_dal.add(studentGroup[0])
        student_dal.add_group(studentGroup[0], studentGroup[1])

    return Ok(message = 'INSERT_OK').toString()

@jwt_required()
def get_all_years(year_dal=YearsDAL()):
    (years, raw_data) = year_dal.get_all()
    return Ok(data = years).toString()