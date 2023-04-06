from src.database.db import db, ma
from src.database.models.class_group import ClassGroup, ClassGroupSchema, ClassGroupSchemaWithoutStudents
from src.database.models.repo_group import RepoGroup, RepoGroupSchema
from src.database.models.pupil_group import PupilGroup, PupilGroupSchema,PupilGroupWithoutStudentSchema
from src.database.models.years import Years, YearsSchema, YearsSchemaWithoutStudents
from src.database.association_table import student_class_group, student_pupil_group
from src.database.association_table import year_student


class Student(db.Model):
    __tablename__ = "students"

    id = db.Column(db.Integer, primary_key=True)
    firstname = db.Column(db.String(25), nullable=False)
    lastname = db.Column(db.String(25), nullable=False)
    email = db.Column(db.String(50), nullable=False)
    uid_ul = db.Column(db.String(25), nullable=False)
    years = db.relationship('Years', secondary=year_student, back_populates="students")
    formation = db.Column(db.String(15), nullable=False)
    projets = db.relationship(
        "StudentRepoGroup", back_populates="student", cascade="all, delete-orphan")
    class_groups = db.relationship(
        'ClassGroup', secondary=student_class_group, back_populates="students")
    pupil_groups = db.relationship(
        'PupilGroup', secondary=student_pupil_group, back_populates="students")

    def __init__(self, firstname, lastname, email, uid_ul, formation):
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.uid_ul = uid_ul
        self.formation = formation

    def __repr__(self):
        return f"<student ({self.id}) {self.firstname} {self.lastname}>"


class StudentSchema(ma.Schema):
    class_groups = ma.Nested(ClassGroupSchema, many=True)
    projets = ma.Nested("StudentRepoGroupSchema_Student", many=True)
    pupil_groups = ma.Nested(PupilGroupSchema, many=True)
    years = ma.Nested(YearsSchemaWithoutStudents, many=True)
    class Meta:
        fields = ("id", "firstname", "lastname", "email", "uid_ul",
                  "years", "formation", "class_groups", "projets", "pupil_groups")
        
class StudentSchemaWithoutProjects(ma.Schema):
    class_groups = ma.Nested(ClassGroupSchemaWithoutStudents, many=True)
    pupil_groups = ma.Nested(PupilGroupSchema, many=True)
    years = ma.Nested(YearsSchemaWithoutStudents, many=True)
    class Meta:
        fields = ("id", "firstname", "lastname", "email", "uid_ul",
                  "years", "formation", "class_groups" ,"pupil_groups")
        
class StudentsWithoutExtraSchema(ma.Schema):
    class Meta:
        fields = ("id", "firstname", "lastname", "email", "uid_ul",
                  "formation")
        