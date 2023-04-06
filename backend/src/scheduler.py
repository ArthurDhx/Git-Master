from flask_apscheduler import APScheduler
from src.database.dals.repo_group_dal import RepoGroupDAL
from datetime import datetime
import uuid
from apscheduler.triggers.date import DateTrigger

scheduler = APScheduler()

def initScheduler(app, repo_group_dal = RepoGroupDAL()):
    with app.app_context():
        (repo_group, raw_data) = repo_group_dal.get_all()
        for repo in raw_data:
            now = datetime.now()
            
            if(repo.start_date < now and (not repo.is_open) and (repo.end_date == None or repo.end_date > now)):
                repo_group_dal.open_repo_group(repo.id_repo, repo.start_date)
            elif(repo.is_open and repo.start_date > now):
                repo_group_dal.close_repo_group(repo.id_repo, repo.end_date)
            elif(repo.is_open and repo.end_date != None and repo.end_date < now ):
                repo_group_dal.close_repo_group(repo.id_repo, repo.end_date)
            elif(repo.start_date > now):
                scheduler.add_job(id=str(uuid.uuid4()),func=repo_group_dal.open_repo_group, args=[repo.id_repo, repo.start_date], trigger=DateTrigger(run_date=datetime(repo.start_date.year,repo.start_date.month, repo.start_date.day, repo.start_date.hour, repo.start_date.minute, 0)))
                
            if(repo.end_date != None and repo.end_date > now):
                scheduler.add_job(id=str(uuid.uuid4()),func=repo_group_dal.close_repo_group, args=[repo.id_repo, repo.end_date], trigger=DateTrigger(run_date=datetime(repo.end_date.year,repo.end_date.month, repo.end_date.day, repo.end_date.hour, repo.end_date.minute, 0)))
        