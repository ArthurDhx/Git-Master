from src.database.db import db, ma

class StudentRepoGroup(db.Model):
    __tablename__ = "student_repo_group"

    id_repo = db.Column(db.Integer, db.ForeignKey('repo_group.id_repo'), primary_key=True)
    id_student = db.Column(db.Integer, db.ForeignKey('students.id'), primary_key=True)
    id_project = db.Column(db.Integer, nullable=False)

    repo = db.relationship("RepoGroup", back_populates="projets")
    student = db.relationship("Student", back_populates="projets")

    def __init__(self, id_repo, id_student, id_project):
        self.id_repo = id_repo
        self.id_student = id_student
        self.id_project = id_project

    def __repr__(self):
        return f"<repo_group ({self.id_repo}) {self.id_student} {self.id_project}>"

class StudentRepoGroupSchema_RepoGroup(ma.Schema):
    student = ma.Nested("StudentSchemaWithoutProjects", many=False)
    class Meta:
        fields = ("id_project", "student")

class StudentRepoGroupSchema_Student(ma.Schema):
    repo = ma.Nested("RepoGroupSchemaWithoutStudents", many=False)
    class Meta:
        fields = ("id_project", "repo")