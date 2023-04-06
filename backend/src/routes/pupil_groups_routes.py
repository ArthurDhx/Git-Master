from flask import Blueprint
from src.controllers.PupilGroupController import get_all_pupil_groups, create_pupil_group, get_pupil_group, edit_pupil_group, delete_pupil_group

# Config blueprint
pupil_groups_routes = Blueprint('pupil_groups_routes', __name__)

# List routes
pupil_groups_routes.route('/all', methods=['GET'])(get_all_pupil_groups)
pupil_groups_routes.route('/<id>', methods=['GET'])(get_pupil_group)
pupil_groups_routes.route('/create', methods=['POST'])(create_pupil_group)
pupil_groups_routes.route('/<id>/edit', methods=['POST'])(edit_pupil_group)
pupil_groups_routes.route(
    '/delete/<id>', methods=['DELETE'])(delete_pupil_group)
