from flask_jwt_extended import jwt_required
from flask import request
from src.responses.response_models import BadRequest
from src.database.models.pupil_group import PupilGroup
from src.database.dals.pupil_group_dal import PupilGroupDAL
from src.database.dals.student_dal import StudentDAL
from src.database.dals.class_group_dal import ClassGroupDAL
from src.responses.response_models import Ok


@jwt_required()
def get_all_pupil_groups(pupil_group_dal=PupilGroupDAL()):
    (pupil_groups, raw_data) = pupil_group_dal.get_all()
    return Ok(data=pupil_groups).toString()


@jwt_required()
def get_pupil_group(id, pupil_group_dal=PupilGroupDAL()):
    (pupil_group, raw_data) = pupil_group_dal.get_by_id(id)
    if not raw_data:
        return BadRequest(message="NOT FOUND").toString()

    return Ok(data=pupil_group).toString()


@jwt_required()
def create_pupil_group(pupil_group_dal=PupilGroupDAL(), student_dal=StudentDAL(), class_group_dal=ClassGroupDAL()):
    # Get data from form
    post_data = request.get_json()
    label_group = post_data.get('label_group')
    list_id = post_data.get('list_id')
    selected_method = post_data.get('selected_method')
    emails_list = post_data.get('emails_list')

    # Check if label_group is existing
    _, pupil_group = pupil_group_dal.get_by_name(label_group)
    if pupil_group:
        return BadRequest(message='LABEL_GROUP_ALREADY_USED').toString()

    # Create new pupil_group
    pupil_group = PupilGroup(label_group)
    pupil_group_dal.add(pupil_group)
    # On récupère le nom du pupil_group
    _, pupil_group = pupil_group_dal.get_by_name(label_group)

    if (list_id != []):
        match selected_method:
            case "StudentsList":
                # Ajoute les étudiants au pupil_group via la liste d'étudiant
                for i in list_id:
                    _, student = student_dal.get_by_id(i)
                    student_dal.add_group(student, pupil_group)

                return Ok(message='INSERT_OK').toString()
            case "ClassGroups":
                # Traitement de passage d'une liste d'id de formation à une liste d'élèves
                for i in list_id:
                    _, class_group = class_group_dal.get_by_id(i)
                    for student in class_group.students:
                        # Ajout des étudiants
                        student_dal.add_group(
                            student, pupil_group)
                return Ok(message='INSERT_OK').toString()

    if (emails_list != []):
        # au cas où la personne se trompe de virgule ou de point-virgule ou fait un mixte des deux
        emails_list_filtered = emails_list.replace(';', ',').split(',')

        # Ajoute les étudiants au pupil_group via la liste d'email
        ListeEmails = [{}]
        for i in emails_list_filtered:
            _, student = student_dal.get_by_email(i)
            # ListeEmails = ({ label: 'aaa@aa.fr', result: 'ok'}),
            ListeEmails.append({i, "ok"})
            if not student:
                ListeEmails.append({i, "pas ok"})
                return BadRequest(message='EMAIL_INVALID').toString()
            student_dal.add_group(student, pupil_group)
        return Ok(message='INSERT_OK').toString()


@jwt_required()
def edit_pupil_group(id, pupil_group_dal=PupilGroupDAL(), student_dal=StudentDAL()):
    _, pupil_group = pupil_group_dal.get_by_id(id)

    # Get data from form
    post_data = request.get_json()
    pupil_group.label_group = post_data.get('label_group')
    list_id = post_data.get('list_id')

    # Check if label_group is existing
    _, pupil_group_List = pupil_group_dal.get_all()
    for i in pupil_group_List:
        if i.label_group == pupil_group.label_group and i.id_pupil_group != pupil_group.id_pupil_group:
            return BadRequest(message='LABEL_GROUP_ALREADY_USED').toString()

    students_new = []
    for i in list_id:
        _, student = student_dal.get_by_id(i)
        students_new.append(student)

    students_old = []
    for student in pupil_group.students:
        students_old.append(student)

    # Update all students
    for student in students_old:
        if student not in students_new:
            student_dal.remove_group(student, pupil_group)

    for student in students_new:
        if student not in students_old:
            student_dal.add_group(student, pupil_group)

    # Sauvegarde
    pupil_group_dal.save(pupil_group)
    return Ok(message='EDIT_OK').toString()


@jwt_required()
def delete_pupil_group(id, pupil_group_dal=PupilGroupDAL()):
    _, pupil_group = pupil_group_dal.get_by_id(id)

    if not pupil_group:
        BadRequest(message='PUPIL_GROUP_NOT_FOUND').toString()

    pupil_group_dal.delete_by_id(id)
    return Ok(message='DELETE_OK').toString()
