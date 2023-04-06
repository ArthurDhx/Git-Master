from src.database.db import db, ma
from src.database.association_table import student_class_group

class ClassGroup(db.Model):
    __tablename__ = "class_group"

    id_group = db.Column(db.Integer, primary_key=True)
    label_group = db.Column(db.String(25), nullable=False)
    students = db.relationship('Student', secondary=student_class_group, back_populates="class_groups", passive_deletes=True)

    def __init__(self, label_group):
        self.label_group = label_group

    def __repr__(self):
        return f"<class_group ({self.id_group}) {self.label_group}>"

class ClassGroupSchema(ma.Schema):
    students = ma.Nested("StudentsWithoutExtraSchema", many=True)
    class Meta:
        fields = ("id_group", "label_group", "students")

class ClassGroupSchemaWithoutStudents(ma.Schema):
    class Meta:
        fields = ("id_group", "label_group")
        

