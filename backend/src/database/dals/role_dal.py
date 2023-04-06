from src.database.models.role import Role, RoleSchema
from src.database.dals.generic_dal import GenericDAL

class RoleDAL(GenericDAL):

    def __init__(self):
        super().__init__(Role, RoleSchema)

    def get_by_name(self, _name):
        entity = self.entity.query.filter_by(label_role = _name).first()
        return self.schema.dump(entity), entity