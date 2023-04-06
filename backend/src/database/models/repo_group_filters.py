from src.database.db import db, ma

class RepoFilters(db.Model):
    __tablename__ = "repo_group_filters"
    
    id = db.Column(db.Integer, primary_key=True)
    id_repo = db.Column(db.Integer, db.ForeignKey('repo_group.id_repo'), nullable=False)
    repo = db.relationship("RepoGroup", back_populates="file_columns")
    file_path = db.Column(db.String(150), nullable=False)
    
    def __init__(self, id_repo, file_path):
        self.id_repo = id_repo
        self.file_path = file_path

    def __repr__(self):
        return f"<RepoFilter ({self.id}) {self.id_repo} {self.file_path}>"

class RepoFiltersSchema(ma.Schema):
    class Meta:
        fields = ("id", "file_path")
        