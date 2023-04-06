from flask import Blueprint
from src.controllers.ClassGroupController import get_all_class_group

# Config blueprint
class_group_routes = Blueprint('class_group_routes', __name__)

# List routes
class_group_routes.route('/all', methods=['GET'])(get_all_class_group)
