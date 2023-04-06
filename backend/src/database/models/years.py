from src.database.db import db, ma
from src.database.association_table import year_student

class Years(db.Model):
    __tablename__ = "years"

    id_year = db.Column(db.Integer, primary_key=True)
    label_year = db.Column(db.String(25), nullable=False)
    students = db.relationship('Student', secondary=year_student, back_populates="years")

    def __init__(self, label_year):
        self.label_year = label_year

    def __repr__(self):
        return f"<year ({self.id_year}) {self.label_year}>"

class YearsSchema(ma.Schema):
    students = ma.Nested("YearsSchema", many=True)
    class Meta:
        fields = ("id_year", "label_year", "students")

class YearsSchemaWithoutStudents(ma.Schema):
    class Meta:
        fields = ("id_year", "label_year")
        

