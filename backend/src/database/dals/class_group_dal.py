from src.database.models.class_group import ClassGroup, ClassGroupSchema
from src.database.dals.generic_dal import GenericDAL


class ClassGroupDAL(GenericDAL):

    def __init__(self):
        super().__init__(ClassGroup, ClassGroupSchema)

    def add_group(self, student, group):
        student.class_groups.append(group)
        self.save(group)

    def get_all_by_formation(self, label_group):
        entities = self.entity.query.filter_by(label_group=label_group).all()
        return self.schema.dump(entities), entities
    
    def get_by_name(self, _name):
        entity = self.entity.query.filter_by(label_group = _name).first()
        return self.schema.dump(entity), entity