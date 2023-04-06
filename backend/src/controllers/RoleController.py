from flask_jwt_extended import jwt_required, get_jwt_identity
from src.responses.response_models import Ok
from src.database.dals.role_dal import RoleDAL
from src.database.models.role import Role

from flask import request
from src.responses.response_models import BadRequest, Ok

def get_roles(role_dal = RoleDAL()):
    data, raw_data = role_dal.get_all()
    return Ok(data = data).toString()

def get_role_by_id(id,role_dal = RoleDAL()):
    data, raw_data = role_dal.get_by_id(id)
    return Ok(data = data).toString()

def edit_role(id, role_dal=RoleDAL()):
    _, role = role_dal.get_by_id(id)

    # Get data from form
    post_data = request.get_json()
    role.display_role = post_data.get('name')

    # Sauvegarde
    role_dal.save(role)

    return Ok(message = 'EDIT_OK').toString()

def delete_role(id, role_dal=RoleDAL()):
    _, group = role_dal.get_by_id(id)

    if not group:
        BadRequest(message = 'ROLE_NOT_FOUND').toString()

    role_dal.delete_by_id(id)
    return Ok(message = 'DELETE_OK').toString()

def create_role(role_dal=RoleDAL()):
    # Get data from form
    post_data = request.get_json()
    name = post_data.get('name')

    # Create new role
    role = Role('', name)
    role_dal.add(role)
    
    return Ok(message = 'INSERT_OK').toString()