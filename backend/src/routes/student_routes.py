from flask import Blueprint
from src.controllers.StudentController import create_students, get_all_students,create_student, edit_student,get_student, delete_student, get_all_class_groups, get_all_years

# Config blueprint
student_routes = Blueprint('student_routes', __name__)

# List routes
student_routes.route('/all', methods=['GET'])(get_all_students)
student_routes.route('/class_groups/all', methods=['GET'])(get_all_class_groups)
student_routes.route('/create', methods=['POST'])(create_student)
student_routes.route('/creates', methods=['POST'])(create_students)
student_routes.route('/<id>/edit', methods=['POST'])(edit_student)
student_routes.route('/<id>', methods=['GET'])(get_student)
student_routes.route('/delete/<id>', methods=['DELETE'])(delete_student)
student_routes.route('/years/all', methods=['GET'])(get_all_years)
