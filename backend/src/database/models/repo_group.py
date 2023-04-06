from src.database.db import db, ma
from src.database.association_table import user_repo_group
from src.database.models.repo_group_filters import RepoFilters

class RepoGroup(db.Model):
    __tablename__ = "repo_group"

    id_repo = db.Column(db.Integer, primary_key=True)
    label_group = db.Column(db.String(25), nullable=False)
    start_date = db.Column(db.DateTime, nullable=False)
    end_date = db.Column(db.DateTime, nullable=True)
    id_creator =db.Column(db.Integer, db.ForeignKey('users.id_user'), nullable=False)
    is_open = db.Column(db.Boolean, nullable=False)
    projets = db.relationship("StudentRepoGroup", back_populates="repo", cascade="all, delete-orphan")
    users = db.relationship("User", secondary=user_repo_group, back_populates="repo_group")
    creator = db.relationship("User", back_populates="creator_group")
    file_columns = db.relationship("RepoFilters", back_populates="repo")

    def __init__(self, id_repo, label_group, start_date, end_date, id_creator):
        self.id_repo = id_repo
        self.label_group = label_group
        self.start_date = start_date
        self.end_date = end_date
        self.id_creator = id_creator
        self.is_open = False

    def __repr__(self):
        return f"<repo_group ({self.id_repo}) {self.label_group} {self.id_creator}>"

class RepoGroupSchema(ma.Schema):
    projets = ma.Nested("StudentRepoGroupSchema_RepoGroup", many=True)
    users = ma.Nested("UserSchemaIdentity", many=True)
    creator = ma.Nested("UserSchemaIdentity", many=False)
    file_columns = ma.Nested("RepoFiltersSchema", many=True)

    class Meta:
        fields = ("id_repo", "label_group", "projets", "start_date", "end_date", "id_creator", "users", "creator", "is_open", "file_columns")

class RepoGroupSchemaWithoutStudents(ma.Schema):
    class Meta:
        fields = ("id_repo", "label_group", "start_date", "end_date", "is_open")
        
class RepoGroupSchemaWithoutUsers(ma.Schema):
    projets = ma.Nested("StudentRepoGroupSchema_RepoGroup", many=True)
    
    class Meta:
        fields = ("id_repo", "label_group", "projets", "start_date", "end_date", "is_open")