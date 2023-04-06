import axios from 'axios';
import store from '../store';
import Utils from './Utils';

const GITAPI = 'https://gitlab.telecomnancy.univ-lorraine.fr/api/v4';

class GitLabService {

    createGroup(payload) {
        const data = {
            name: payload.name,
            path: payload.name
        };
        const headers = this.getRequestHeaders();

        return axios.post(`${GITAPI}/groups`, data, { headers: headers })
            .then(response => {
                return response;
            })
            .catch(error => {
                let erreur = '';

                if (error.response.data.message.includes("401 Unauthorized")) {
                    erreur = 'Problème de configuration de votre Token GITLAB.';
                }
                else if (error.response.data.message.includes("has already been taken")) {
                    erreur = 'Le nom de projet existe déjà.';
                }
                else if (error.response.data.message.includes("can contain only letters, digits")) {
                    erreur = 'Nom de groupe incorrect (espaces interdits).';
                }
                else {
                    erreur = 'Problème interne venant de GITLAB.';
                }

                return {
                    error: -1,
                    error_message: erreur
                };
            });
    }

    deleteGroup(id_group) {
        const headers = this.getRequestHeaders();

        return axios.delete(`${GITAPI}/groups/${id_group}`, { headers: headers })
            .then(response => {
                return response.data;
            })
            .catch(() => {});
    }

    addCommit(data) {
        // Construction de la structure du payload
        const payload = {
            "branch": data.branch_name,
            "commit_message": data.commit_message,
            "actions": data.actions
        };

        // Récupération des headers
        const headers = this.getRequestHeaders();

        // Envoi de la requête vers l'API
        return axios.post(`${GITAPI}/projects/${data.project_id}/repository/commits`, payload, { headers: headers })
            .then(response => {
                return response.data;
            })
            .catch(error => {
                let error_msg = '';

                if (error.response.data.message.includes("branch is empty")) {
                    error_msg = 'Commit impossible, aucun nom de branche renseigné.';
                }
                else if (error.response.data.message.includes("empty CommitMessage")) {
                    error_msg = 'Commit impossible, aucun message de commit renseigné.';
                }
                else if (error.response.data.message.includes("A file with this name already exists")) {
                    error_msg = 'Commit impossible, un fichier avec un path identique existe déjà.';
                }
                else {
                    error_msg = 'Problème interne venant de GITLAB.';
                }

                return {
                    error: -1,
                    error_message: error_msg
                };
            });
    }

    getUser(email) {
        const headers = this.getRequestHeaders();

        return axios.get(`${GITAPI}/users?search=${email}`, { headers: headers })
            .then(response => {
                return response.data;
            })
            .catch(() => {});
    }

    getProjectInfo(id_project) {
        const headers = this.getRequestHeaders();

        return axios.get(`${GITAPI}/projects/${id_project}`, { headers: headers })
            .then(response => {
                return response.data;
            })
            .catch(() => {});
    }

    getProjectContributors(id_project) {
        const headers = this.getRequestHeaders();

        return axios.get(`${GITAPI}/projects/${id_project}/repository/contributors`, { headers: headers })
            .then(response => {
                return response.data;
            })
            .catch(() => {});
    }

    getProjectFilesTree(id_project) {
        const headers = this.getRequestHeaders();

        return axios.get(`${GITAPI}/projects/${id_project}/repository/tree?per_page=100&recursive=true`, { headers: headers })
            .then(response => {
                return response.data;
            })
            .catch(() => {
                return [];
            });
    }

    getProjectBranches(id_project) {
        const headers = this.getRequestHeaders();

        return axios.get(`${GITAPI}/projects/${id_project}/repository/branches`, { headers: headers })
            .then(response => {
                return response.data;
            })
            .catch(() => {
                return [];
            });
    }

    getProjectUsers(id_project) {
        const headers = this.getRequestHeaders();

        return axios.get(`${GITAPI}/projects/${id_project}/users`, { headers: headers })
            .then(response => {
                return response.data;
            })
            .catch(() => {
                return [];
            });
    }

    // https://docs.gitlab.com/ee/api/commits.html#commits-api
    getProjectCommits(id_project) {
        const headers = this.getRequestHeaders();

        return axios.get(`${GITAPI}/projects/${id_project}/repository/commits`, { headers: headers })
            .then(response => {
                return response.data;
            })
            .catch(() => {
                return [];
            });
    }

    loadRepoInformations(repo) {
        const promises = [];

        for (const projet in repo.projets) {
            promises.push(
                this.getProjectInfo(repo.projets[projet].id_project).then(result => {
                    repo.projets[projet].info_gitlab = result;
                }),
                this.getProjectContributors(repo.projets[projet].id_project).then(result => {
                    repo.projets[projet].contributors = result;
                }),
                this.getProjectBranches(repo.projets[projet].id_project).then(result => {
                    repo.projets[projet].branches = result;
                }),
                this.getProjectCommits(repo.projets[projet].id_project).then(result => {
                    repo.projets[projet].commits = result;
                }),
                this.getProjectUsers(repo.projets[projet].id_project).then(result => {
                    repo.projets[projet].users = result;
                })
            );
        }

        // For each project, if not empty => get files tree
        return Promise.all(promises).then(() => {
            for (const projet in repo.projets) {
                if (!repo.projets[projet].info_gitlab.empty_repo) {
                    this.getProjectFilesTree(repo.projets[projet].id_project).then(result => {
                        repo.projets[projet].files = result;
                    });
                } else {
                    repo.projets[projet].files = [];
                }
            }

            return repo;
        });
    }

    loadProjectInformations(project) {        
        const promises = [];

        promises.push(
            this.getProjectInfo(project.id_project).then(result => {
                project.info_gitlab = result;
            }),
            this.getProjectCommits(project.id_project).then(result => {
                project.commits = result;
            }),
            this.getProjectBranches(project.id_project).then(result => {
                project.branches = result;
            }),
            this.getProjectContributors(project.id_project).then(result => {
                project.contributors = result;
            }),
            this.getProjectUsers(project.id_project).then(result => {
                project.users = result;
            })
        );

        return Promise.all(promises).then(() => {
            if (!project.info_gitlab.empty_repo) {
                this.getProjectFilesTree(project.id_project).then(result => {
                    project.files = result;
                });
            } else {
                project.files = [];
            }
        });
    }
    

    deleteProject(id_project) {
        const headers = this.getRequestHeaders();

        return axios.delete(`${GITAPI}/projects/${id_project}`, { headers: headers })
            .then(response => {
                return response.data;
            })
            .catch(() => {});
    }

    // En fonction de la valeur de la propriété "action" de data, un object avec les bonnes propriétés est créé
    // Il suffit d'inclure dans data les propriétés nécessaires pour l'action ciblée
    async getCommitAction(data) {
        const generic = { "action": data.action };
        let specific = {};

        switch (data.action) {
        case "create":
        case "update":
            await Utils.encodeFileToBase64(data.file).then((base64) => {
                specific = {
                    "file_path": data.file_path,
                    "content": base64,
                    "encoding": "base64"
                };
            });
            break;
        case "delete":
            specific = {
                "file_path": data.file_path
            };
            break;
        case "move":
            specific = {
                "file_path": data.file_path,
                "previous_path": data.previous_path
            };
            break;
        case "chmod":
            specific = {
                "file_path": data.file_path,
                "execute_filemode": true
            };
            break;
        default:
            break;
        }

        return { ...generic, ...specific };
    }

    getRequestHeaders() {
        return {
            'Content-Type': 'application/json',
            'PRIVATE-TOKEN': store.getters['user/getUserInfos'].token_gitlab
        };
    }
}

export default new GitLabService();
