from flask_jwt_extended import jwt_required, get_jwt_identity
from src.responses.response_models import Ok, BadRequest
from src.database.dals.user_dal import UserDAL


@jwt_required()
def me(user_dal = UserDAL()):
    user_id = get_jwt_identity() # Get USER_ID from JWT
    data, raw_data = user_dal.get_by_id(user_id)

    if not raw_data:
        return BadRequest(message = "NOT_FOUND").toString()

    return Ok(data = data).toString()

@jwt_required()
def get_all_users(user_dal=UserDAL()):
    (users, raw_data) = user_dal.get_all()
    return Ok(data = users).toString()
    
@jwt_required()
def get_user(id, user_dal=UserDAL()):
    (user, raw_data) = user_dal.get_by_id(id)
    if not raw_data:
        return BadRequest(message = "NOT FOUND").toString()

    return Ok(data = user).toString()


@jwt_required()
def get_all_teachers(userDal=UserDAL()):
    teachers, raw_data = userDal.get_all_teachers()
    if not raw_data:
        return BadRequest(message = "NOT FOUND").toString()
    return Ok(data = teachers).toString()