from src.database.models.repo_group_filters import RepoFilters, RepoFiltersSchema
from src.database.dals.generic_dal import GenericDAL

class RepoGroupFilterDAL(GenericDAL):

    def __init__(self):
        super().__init__(RepoFilters, RepoFiltersSchema)

    def get_by_label(self, label):
        raw_entity = self.entity.query.filter_by(file_path = label).first()
        return self.schema.dump(raw_entity), raw_entity        