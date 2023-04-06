from src.database.models.user import User, UserSchema
from src.database.dals.generic_dal import GenericDAL
from src.database.models.role import Role, RoleSchema

class UserDAL(GenericDAL):

    def __init__(self):
        super().__init__(User, UserSchema)

    def get_by_email(self, email):
        raw_entity = self.entity.query.filter_by(email = email).first()
        return self.schema.dump(raw_entity), raw_entity

    def add_role(self, user, role):
        role.users.append(user)
        self.save(role)

    def remove_role(self, user, role):
        role.users.remove(user)
        self.save(role)
        
    def get_all_teachers(self):
        raw_entities = self.entity.query.filter(self.entity.roles.any(Role.label_role == "teacher")).all()
        return self.schemas.dump(raw_entities), raw_entities
    
    def add_repo_group(self, user, repo_group):
        repo_group.users.append(user)
        self.save(repo_group)
        
    def remove_repo_group(self, user, repo_group):
        repo_group.users.remove(user)
        self.save(repo_group)
    