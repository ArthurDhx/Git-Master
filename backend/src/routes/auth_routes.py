from flask import Blueprint
from src.controllers.UserController import me, get_all_users, get_user

# Config blueprint
auth_routes = Blueprint('auth_routes', __name__)

# List routes
auth_routes.route('/', methods=['GET'])(me)
auth_routes.route('/all', methods=['GET'])(get_all_users)
auth_routes.route('/<id>', methods=['GET'])(get_user)