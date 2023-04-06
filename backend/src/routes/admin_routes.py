from flask import Blueprint
from src.controllers.AdminController import create_user, edit_user, delete_user, delete_group, get_all_class_groups, create_group, edit_group, get_group_by_id, get_group_by_id, get_all_years, delete_year, create_year, edit_year, get_year_by_id
from src.controllers.RoleController import get_roles, get_role_by_id, edit_role, delete_role, create_role
# Config blueprint
admin_routes = Blueprint('admin_routes', __name__)

# List routes
admin_routes.route('/user/create', methods=['POST'])(create_user)
admin_routes.route('/user/<id>/edit', methods=['POST'])(edit_user)
admin_routes.route('/user/<id>', methods=['DELETE'])(delete_user)
admin_routes.route('/group/<id>', methods=['DELETE'])(delete_group)
admin_routes.route('/year/<id>', methods=['DELETE'])(delete_year)
admin_routes.route('/group/all', methods=['GET'])(get_all_class_groups)
admin_routes.route('/group/create', methods=['POST'])(create_group)
admin_routes.route('/group/<id>/edit', methods=['POST'])(edit_group)
admin_routes.route('/group/<id>', methods=['GET'])(get_group_by_id)
admin_routes.route('/year/all', methods=['GET'])(get_all_years)
admin_routes.route('/year/create', methods=['POST'])(create_year)
admin_routes.route('/year/<id>/edit', methods=['POST'])(edit_year)
admin_routes.route('/year/<id>', methods=['GET'])(get_year_by_id)
admin_routes.route('/role/all', methods=['GET'])(get_roles)
admin_routes.route('/role/<id>', methods=['GET'])(get_role_by_id)
admin_routes.route('/role/<id>/edit', methods=['POST'])(edit_role)
admin_routes.route('/role/<id>', methods=['DELETE'])(delete_role)
admin_routes.route('/role/create', methods=['POST'])(create_role)

