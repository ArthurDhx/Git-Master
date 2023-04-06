from src.database.models.student import Student, StudentSchema
from src.database.dals.generic_dal import GenericDAL


class StudentDAL(GenericDAL):

    def __init__(self):
        super().__init__(Student, StudentSchema)

    def get_by_uid_ul(self, uid_ul):
        entity = self.entity.query.filter_by(uid_ul=uid_ul).first()
        return self.schema.dump(entity), entity

    def get_by_email(self, email):
        entity = self.entity.query.filter_by(email=email).first()
        return self.schema.dump(entity), entity

    def add_group(self, student, group):
        group.students.append(student)
        self.save(group)
        
    def remove_year(self, student, year):
        student.years.remove(year)
        self.save(student)
        
    def add_year(self, student, year):
        student.years.append(year)
        self.save(student)

    def remove_group(self, student, group):
        if len(group.students) > 1:
            group.students.remove(student)
        else:
            group.students = []
        self.save(group)

    def remove_projet(self, student, projet):
        if len(student.projets) > 1:
            student.projets.remove(projet)
        else:
            student.projets = []
        self.save(student)