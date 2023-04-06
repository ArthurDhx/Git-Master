from src.database.db import db, ma
from src.database.association_table import role_user, user_repo_group
from src.database.models.role import Role, RoleSchema

class User(db.Model):
    __tablename__ = "users"
    
    id_user = db.Column(db.Integer, primary_key=True)
    firstname = db.Column(db.String(25), nullable=False)
    lastname = db.Column(db.String(25), nullable=False)
    uid_ul = db.Column(db.String(25), nullable=False)
    password = db.Column(db.String(128), nullable=False)
    email = db.Column(db.String(50), nullable=False)
    id_gitlab = db.Column(db.Integer, nullable=False)
    token_gitlab = db.Column(db.String(100), nullable=True)
    picture = db.Column(db.String(100), nullable=True)
    roles = db.relationship('Role', secondary=role_user, back_populates="users")
    repo_group = db.relationship('RepoGroup', secondary=user_repo_group, back_populates="users")
    creator_group = db.relationship("RepoGroup", back_populates="creator")

    def __init__(self, firstname, lastname, uid_ul, password, email, id_gitlab, token_gitlab, picture):
        self.firstname = firstname
        self.lastname = lastname
        self.uid_ul = uid_ul
        self.password = password
        self.email = email
        self.id_gitlab = id_gitlab
        self.token_gitlab = token_gitlab
        self.picture = picture

    def __repr__(self):
        return f"<User ({self.id_user}) {self.firstname} {self.lastname}>"

class UserSchema(ma.Schema):
    roles = ma.Nested(RoleSchema, many=True)
    repo_group = ma.Nested("RepoGroupSchemaWithoutUsers", many=True)

    class Meta:
        fields = ("id_user", "firstname", "lastname", "uid_ul", "email", "picture", "roles", "id_gitlab", "token_gitlab", "repo_group")
        
class UserSchemaIdentity(ma.Schema):
    
    class Meta:
        fields = ("id_user", "id_gitlab", "firstname", "lastname")