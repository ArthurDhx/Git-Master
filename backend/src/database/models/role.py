from src.database.db import db, ma
from src.database.association_table import role_user

class Role(db.Model):
    __tablename__ = "roles" 
    
    id_role = db.Column(db.Integer, primary_key=True)
    label_role = db.Column(db.String(25))
    display_role = db.Column(db.String(25))
    users = db.relationship('User', secondary=role_user, back_populates="roles")
    
    def __init__(self, label_role, display_role):
        self.label_role = label_role
        self.display_role = display_role

    def __repr__(self):
        return f"<Role {self.label_role} {self.display_role}>"

class RoleSchema(ma.Schema):
    users = ma.Nested("RoleSchema", many=True)
    class Meta:
        fields = ("id_role", "label_role", "display_role", "users")
