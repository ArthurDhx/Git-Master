from src.database.models.pupil_group import PupilGroup, PupilGroupSchema
from src.database.dals.generic_dal import GenericDAL
from src.database.association_table import student_pupil_group
from src.database.models.student import Student


class PupilGroupDAL(GenericDAL):

    def __init__(self):
        super().__init__(PupilGroup, PupilGroupSchema)

    def get_by_name(self, _name):
        entity = self.entity.query.filter_by(label_group=_name).first()
        return self.schema.dump(entity), entity

    def get_students_by_id(self, _id):
        students = self.db_session.query(Student).join(student_pupil_group).filter(
            student_pupil_group.c.id_pupil_group == _id).all()
        return self.schemas.dump(students), students
