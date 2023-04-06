from flask import request, jsonify
from flask_jwt_extended import create_access_token
from flask_jwt_extended import jwt_required

from src.database.dals.user_dal import UserDAL
from src.responses.response_models import BadRequest, Ok

def login(user_dal = UserDAL()):
    # Check request
    data = request.get_json()
    email = data.get('email')
    password = data.get('password')

    if not email or not password:
        return BadRequest(message = "LOGIN_BAD_FORM").toString()

    # Check if account exist
    (current_user, raw_data) = user_dal.get_by_email(email)

    if not current_user:
        return BadRequest(message = "LOGIN_USER_NOT_EXIST").toString()

    # Check password
    from src import bcrypt
    if not bcrypt.check_password_hash(raw_data.password, password):
         return BadRequest(message = "LOGIN_BAD_PASSWORD").toString()

    # Generate JWT
    additional_claims = {"roles": current_user['roles']}
    token = create_access_token(identity = raw_data.id_user, additional_claims = additional_claims)

    # Response
    data = {
        'user_infos' : current_user,
        'token' : token
    }
  
    return Ok(data = data).toString()