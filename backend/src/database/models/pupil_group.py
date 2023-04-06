from src.database.db import db, ma
from src.database.association_table import student_pupil_group


class PupilGroup(db.Model):
    __tablename__ = "pupil_group"

    id_pupil_group = db.Column(db.Integer, primary_key=True)
    label_group = db.Column(db.String(100), nullable=False)
    students = db.relationship('Student', secondary=student_pupil_group,
                               back_populates="pupil_groups", passive_deletes=True)

    def __init__(self, label_group):
        self.label_group = label_group

    def __repr__(self):
        return f"<pupil_group ({self.id_pupil_group}) {self.label_group}>"


class PupilGroupSchema(ma.Schema):
    students = ma.Nested("StudentSchema", many=True, exclude=("pupil_groups",))
    class Meta:
        fields = ("id_pupil_group", "label_group", "students")
        
class PupilGroupWithoutStudentSchema(ma.Schema):
    class Meta:
        fields = ("id_pupil_group", "label_group")
