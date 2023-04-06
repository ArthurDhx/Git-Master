from src.database.models.years import Years, YearsSchema
from src.database.dals.generic_dal import GenericDAL


class YearsDAL(GenericDAL):

    def __init__(self):
        super().__init__(Years, YearsSchema)

    def get_by_name(self, _name):
        entity = self.entity.query.filter_by(label_year = _name).first()
        return self.schema.dump(entity), entity