from src.database.models.repo_group import RepoGroup, RepoGroupSchema
from src.database.dals.generic_dal import GenericDAL
from src.services.gitLabServices import changeStudentRole

class RepoGroupDAL(GenericDAL):

    def __init__(self):
        super().__init__(RepoGroup, RepoGroupSchema)

    def add_project(self, group, project):
        group.projets.append(project)
        self.save(group)
    
    def delete_project(self, group, project):
        group.projets.remove(project)
        self.save(group)

    def open_repo_group(self, repo_id, date):
        from src.scheduler import scheduler
        with scheduler.app.app_context():
            (_, repo) = self.get_by_id(repo_id)

            if repo.start_date == date:
                for project in repo.projets:
                    changeStudentRole(repo.creator.token_gitlab, project.id_project, 10, 30)
                    
                repo.is_open = True
                self.save(repo)
            
    def close_repo_group(self, repo_id, date):
        from src.scheduler import scheduler
        with scheduler.app.app_context():
            (_, repo) = self.get_by_id(repo_id)
        
            if repo.end_date == date:
                for project in repo.projets:
                    changeStudentRole(repo.creator.token_gitlab, project.id_project, 30, 10)
                    
                repo.is_open = False
                self.save(repo)        