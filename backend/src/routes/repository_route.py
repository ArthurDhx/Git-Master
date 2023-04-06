from flask import Blueprint
from src.controllers.RepositoryController import create_repo_group, edit_repo_group, add_filter, delete_filter, delete_repo_group, get_all_repo_group, get_repo_group, delete_project, delete_project_contributor
from src.controllers.UserController import get_all_teachers

# Config blueprint
repository_routes = Blueprint('repository_routes', __name__)

# List routes
repository_routes.route('/create', methods=['POST'])(create_repo_group)
repository_routes.route('/<id>/edit', methods=['POST'])(edit_repo_group)
repository_routes.route('/<id>/delete', methods=['DELETE'])(delete_repo_group)
repository_routes.route('/delete_filter/<id_filter>', methods=['DELETE'])(delete_filter)
repository_routes.route('/<id>/add_filter', methods=['POST'])(add_filter)
repository_routes.route('/', methods=['GET'])(get_all_repo_group)
repository_routes.route('/<id>', methods=['GET'])(get_repo_group)
repository_routes.route('/<id_group>/<id_project>/<id_contributor>/<id_gitlab>/delete_project', methods=['DELETE'])(delete_project)
repository_routes.route('/<id_group>/<id_project>/<id_contributor>/<id_gitlab>/delete_contributor', methods=['DELETE'])(delete_project_contributor)
repository_routes.route('/teacher/all', methods=['GET'])(get_all_teachers)