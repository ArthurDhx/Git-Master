from flask_jwt_extended import jwt_required
from src.database.models.user import User
from src.database.models.class_group import ClassGroup
from src.database.models.years import Years
from flask import request

from src.database.dals.user_dal import UserDAL
from src.database.dals.role_dal import RoleDAL
from src.database.dals.class_group_dal import ClassGroupDAL
from src.database.dals.years_dal import YearsDAL

from src.responses.response_models import BadRequest, Ok
from src.decorator import admin_required

@jwt_required()
@admin_required()
def create_user(user_dal=UserDAL(), role_dal= RoleDAL()):
    # Get data from form
    post_data = request.get_json()
    firstname = post_data.get('firstname')
    lastname = post_data.get('lastname')
    email = post_data.get('email')
    uid_ul = post_data.get('uid_ul')
    password = post_data.get('password')
    id_gitlab = post_data.get('id_gitlab')
    token_gitlab = post_data.get('token_gitlab')
    picture = post_data.get('picture')

    # Check if email is existing
    _, user = user_dal.get_by_email(email)
    if user:
        return BadRequest(message = 'EMAIL_ALREADY_USED').toString()

    # Hash password
    from src import bcrypt
    hashed_pwd = bcrypt.generate_password_hash(password).decode('utf-8')
    
    # Create new user
    user = User(firstname, lastname, uid_ul, hashed_pwd, email, id_gitlab, token_gitlab, picture)
    user_id = user_dal.add(user)

    # Add roles
    roles = post_data.get('roles')
    for id_role in roles:
        role, raw_data = role_dal.get_by_id(id_role)
        user_dal.add_role(user, raw_data)

    return Ok(message = 'INSERT_OK').toString()

@admin_required()
@jwt_required()
def edit_user(id, user_dal=UserDAL(), role_dal= RoleDAL()):
    _, user = user_dal.get_by_id(id)

    # Get data from form
    post_data = request.get_json()
    user.firstname = post_data.get('firstname')
    user.lastname = post_data.get('lastname')
    user.email = post_data.get('email')
    user.uid_ul = post_data.get('uid_ul')
    user.id_gitlab = post_data.get('id_gitlab')
    user.token_gitlab = post_data.get('token_gitlab')
    user.picture = post_data.get('picture')
    password = post_data.get('password')

    # Check if email is existing
    _, otherUser = user_dal.get_by_email(user.email)
    if otherUser and otherUser.id_user != int(id):
        return BadRequest(message = 'EMAIL_ALREADY_USED').toString()

    # Update password 
    if password:
        from src import bcrypt
        user.password = bcrypt.generate_password_hash(password).decode('utf-8')
    
    # Sauvegarde
    user_dal.save(user)

    # Roles
    roles = post_data.get('roles')

    # Delete role
    for role in user.roles:
        if role.id_role not in roles:
            _, raw_data = role_dal.get_by_id(role.id_role)
            user_dal.remove_role(user, raw_data)

    # Add role
    for id_role in roles:
        _, raw_data = role_dal.get_by_id(id_role)
        user_dal.add_role(user, raw_data)

    return Ok(message = 'EDIT_OK').toString()

@admin_required()
@jwt_required()
def delete_user(id, user_dal=UserDAL()):
    _, user = user_dal.get_by_id(id)

    if not user:
        BadRequest(message = 'USER_NOT_FOUND').toString()

    for role in user.roles:
        user_dal.remove_role(user, role)

    user_dal.delete_by_id(id)
    return Ok(message = 'DELETE_OK').toString()

@jwt_required()
def get_all_class_groups(group_dal = ClassGroupDAL()):
    data, raw_data = group_dal.get_all()
    return Ok(data = data).toString()


@admin_required()
@jwt_required()
def delete_group(id, group_dal=ClassGroupDAL()):
    _, group = group_dal.get_by_id(id)

    if not group:
        BadRequest(message = 'GROUP_NOT_FOUND').toString()

    group_dal.delete_by_id(id)
    return Ok(message = 'DELETE_OK').toString()

@jwt_required()
@admin_required()
def create_group(group_dal=ClassGroupDAL()):
    # Get data from form
    post_data = request.get_json()
    name = post_data.get('name')

    # Create new group
    group = ClassGroup(name)
    group_dal.add(group)
    
    return Ok(message = 'INSERT_OK').toString()

@jwt_required()
@admin_required()
def get_group_by_id(id, group_dal=ClassGroupDAL()):
    data, raw_data = group_dal.get_by_id(id)
    return Ok(data = data).toString()

@jwt_required()
@admin_required()
def edit_group(id, group_dal=ClassGroupDAL()):
    _, group = group_dal.get_by_id(id)

    # Get data from form
    post_data = request.get_json()
    group.label_group = post_data.get('name')

    # Sauvegarde
    group_dal.save(group)

    return Ok(message = 'EDIT_OK').toString()

@jwt_required()
@admin_required()
def get_all_years(year_student_dal=YearsDAL()):
    data, raw_data = year_student_dal.get_all()
    return Ok(data = data).toString()


@admin_required()
@jwt_required()
def delete_year(id, year_student_dal=YearsDAL()):
    _, group = year_student_dal.get_by_id(id)

    if not group:
        BadRequest(message = 'YEAR_NOT_FOUND').toString()

    year_student_dal.delete_by_id(id)
    return Ok(message = 'DELETE_OK').toString()

@jwt_required()
@admin_required()
def create_year(year_student_dal=YearsDAL()):
    # Get data from form
    post_data = request.get_json()
    name = post_data.get('name')

    # Create new year
    year = Years(name)
    year_student_dal.add(year)
    
    return Ok(message = 'INSERT_OK').toString()

@jwt_required()
@admin_required()
def edit_year(id, year_student_dal=YearsDAL()):
    _, year = year_student_dal.get_by_id(id)

    # Get data from form
    post_data = request.get_json()
    year.label_year = post_data.get('name')

    # Sauvegarde
    year_student_dal.save(year)

    return Ok(message = 'EDIT_OK').toString()


@jwt_required()
@admin_required()
def get_year_by_id(id, year_student_dal=YearsDAL()):
    data, raw_data = year_student_dal.get_by_id(id)
    return Ok(data = data).toString()