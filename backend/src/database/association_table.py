from src.database.db import db, ma

role_user = db.Table('role_user', db.Column('id_user', db.Integer, db.ForeignKey('users.id_user')),
                     db.Column('id_role', db.Integer, db.ForeignKey('roles.id_role')))


student_class_group = db.Table('student_class_group', db.Column('id_class', db.Integer, db.ForeignKey('class_group.id_group')),
                               db.Column('id_student', db.Integer, db.ForeignKey('students.id')))

student_pupil_group = db.Table('student_pupil_group', db.Column('id_pupil_group', db.Integer, db.ForeignKey('pupil_group.id_pupil_group')),
                               db.Column('id_student', db.Integer, db.ForeignKey('students.id')))

user_repo_group = db.Table('user_repo_group', db.Column('id_repo', db.Integer, db.ForeignKey('repo_group.id_repo')),
                               db.Column('id_user', db.Integer, db.ForeignKey('users.id_user')))

year_student = db.Table('year_student', db.Column('id_year', db.Integer, db.ForeignKey('years.id_year')),
                               db.Column('id_student', db.Integer, db.ForeignKey('students.id')))

