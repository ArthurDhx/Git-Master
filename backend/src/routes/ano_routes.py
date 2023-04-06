from flask import Blueprint
from src.controllers.AuthController import login
from src.controllers.RoleController import get_roles
from src.controllers.PupilGroupController import get_all_pupil_groups

# Config blueprint
ano_routes = Blueprint('ano_routes', __name__)

# List routes
ano_routes.route('/login', methods=['POST'])(login)
ano_routes.route('/roles', methods=['GET'])(get_roles)
ano_routes.route('/pupilsGroup', methods=['GET'])(get_all_pupil_groups)

# Default route
@ano_routes.route('/', methods=['GET'])
def index():
    return "API Index"