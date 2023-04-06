from asyncio.constants import ACCEPT_RETRY_DELAY
from urllib import response
import requests
from flask_jwt_extended import get_jwt_identity
from src.database.dals.user_dal import UserDAL

GITAPI = 'https://gitlab.telecomnancy.univ-lorraine.fr/api/v4'
ACCESS_LEVEL_STUDENT_CLOSE = 10
ACCESS_LEVEL_STUDENT = 30
ACCESS_LEVEL_TEACHER = 40

def createProject(id_repo, name, user_dal = UserDAL()):
    data = {
        'name': name,
        'namespace_id': id_repo
    }
    r = requests.post(url = GITAPI + '/projects', headers=getHeader(), json = data)
    response = r.json()
    return response['id']


def deleteProject(id_project):
    return requests.delete(url = GITAPI + '/projects/' + str(id_project), headers=getHeader())
    
def changeStudentRole(repo_creator_token, id_project, origin, dest):
    # Récupération de l'id de l'utilisateur en fonction de l'email
    result = requests.get(url = GITAPI + '/projects/' + str(id_project) + '/members/all', headers=getRepoHeader(repo_creator_token))
    if(result.status_code == 200):
        students = result.json()
        for student in students:
            if(student['access_level'] == origin):
               requests.put(url = GITAPI + '/projects/' + str(id_project) + '/members/' + str(student['id']) + '?access_level=' + str(dest), headers=getRepoHeader(repo_creator_token)) 

def inviteStudentToProject(email, id_project):
    data = {
        'email': email,
        'access_level': ACCESS_LEVEL_STUDENT_CLOSE
    }
    return requests.post(url = GITAPI + '/projects/' + str(id_project) + '/invitations', headers=getHeader(), json = data)


def inviteTeacherToRepoGroup(email, id_group):
    data = {
        'email': email,
        'access_level': ACCESS_LEVEL_TEACHER
    }
    return requests.post(url = GITAPI + '/groups/' + str(id_group) + '/invitations', headers=getHeader(), json = data)


def removeMemberFromRepoGroup(email, id_group, id_member):
    return requests.delete(url = GITAPI + '/groups/' + str(id_group) + '/members/' + str(id_member), headers=getHeader())

def removeMemberFromProject(email, id_project, id_member):
    return requests.delete(url = GITAPI + '/projects/' + str(id_project) + '/members/' + str(id_member), headers=getHeader())

def deleteRepoGroup(id_group):
    return requests.delete(url = GITAPI + '/groups/' + str(id_group), headers=getHeader())


def getHeader(user_dal = UserDAL()):
    user_id = get_jwt_identity() # Get USER_ID from JWT
    _, raw_data = user_dal.get_by_id(user_id)
    header = {
            'Content-Type': 'application/json',
            'PRIVATE-TOKEN': raw_data.token_gitlab
        }
    return header
    
def getRepoHeader(repo_creator_token):
    header = {
            'Content-Type': 'application/json',
            'PRIVATE-TOKEN': repo_creator_token
        }
    return header