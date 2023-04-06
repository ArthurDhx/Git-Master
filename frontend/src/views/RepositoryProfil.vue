<template>
  <div class="container max-w-5xl mx-auto py-8">
    <h2 class="text-2xl font-bold text-gray-900 sm:text-3xl mb-4 text-center flex justify-center items-center gap-4">
      Groupe GITLAB
      <div class="text-right mb-1">
        <button
          class="rounded-md px-2 py-1 text-sm border border-gray-300 bg-white hover:bg-gray-200 text-gray-600"
          @click="$router.push({ name: 'RepositoriesList' })"
        >
          Retour
        </button>
      </div>
    </h2>

    <div class="w-full shadow px-5 py-2 bg-gray-100">
      <div class="relative">
        <div class="flex items-center justify-between">
          <p
            v-if="editMode"
            class="flex items-center"
          >
            <span
              class="required_field mr-1"
            />
            <input
              v-model="repo.label_group"
              type="text"
              class="bg-white border rounded w-64 py-2 px-3 text-gray-700 text-sm focus:outline-none focus:border-purple-300 disabled:bg-gray-100"
            >
          </p>
          <div v-else>
            <span class="font-medium">{{ repo.label_group }} </span>
            <span class="italic"> (créé par {{ repo.creator.firstname }} {{ repo.creator.lastname }}) - </span>
            <span
              v-if="repo.actif"
              class="rounded-md ml-1 px-1 text-sm text-white bg-green-500"
            >Actif</span>
            <span
              v-else 
              class="rounded-md ml-1 px-1 text-sm text-white bg-red-500"
            >Inactif</span>
          </div>
          <div>
            <button
              v-if="editMode"
              class="px-4 py-2 border border-gray-300 bg-white hover:bg-gray-200 text-gray-600 text-sm font-medium rounded-md"
              @click="cancelEdition()"
            >
              Annuler
            </button>
            <button
              v-if="editMode"
              class="px-4 py-2 rounded-md font-medium text-white bg-purple-500 hover:bg-purple-600 text-sm  ml-2"
              @click="saveEdition()"
            >
              Sauvegarder
            </button>
            <button
              v-if="!editMode"
              class="px-4 py-2 border border-gray-300 bg-white hover:bg-gray-200 text-gray-600 text-sm font-medium rounded-md"
              @click="edit()"
            >
              Modifier
            </button>
            <button
              v-if="(!editMode && !repo.actif && repo.creator.id_user == current_user.id_user)"
              class="ml-1 px-4 py-2 border border-gray-300 bg-red-500 hover:bg-red-600 text-white text-sm font-medium rounded-md"
              @click="remove()"
            >
              Supprimer
            </button>
          </div>
        </div>

        <div class="grid md:grid-cols-3 grid-cols-2 gap-3 mt-2 border-t border-gray-300 py-3">
          <div>
            <span
              class="text-gray-700 block text-sm font-medium mb-2"
              :class="{ 'required_field': editMode }"
            >Enseignant(s)</span>
            <Multiselect
              v-model="teachers"
              :disabled="!editMode"
              :options="teachersList"
              object
              mode="tags"
              placeholder="Choisir les enseignants"
              :close-on-select="false"
              :searchable="true"
              class="multiselect border border-gray-400 text-gray-700 text-sm focus:outline-none focus:border-purple-300"
            />
          </div>

          <div>
            <span
              class="text-gray-700 block text-sm font-medium mb-2"
              :class="{ 'required_field': editMode }"
            >Date de début</span>
            <input
              v-model="repo.start_date"
              :disabled="!editMode"
              type="datetime-local"
              class="bg-white border rounded w-full py-2 px-3 text-gray-700 text-sm focus:outline-none focus:border-purple-300 disabled:bg-gray-100"
            >
          </div>

          <div>
            <span class="text-gray-700 block text-sm font-medium mb-2">Date de fin</span>
            <input
              v-model="repo.end_date"
              :disabled="!editMode"
              type="datetime-local"
              class="bg-white border rounded w-full py-2 px-3 text-gray-700 text-sm focus:outline-none focus:border-purple-300 disabled:bg-gray-100"
            >
          </div>
        </div>
      </div>
    </div>
    <div>
      <div class="mt-6">
        <ul class="hidden text-sm font-medium text-center text-gray-500 rounded-lg divide-x divide-gray-200 shadow sm:flex">
          <li class="w-full">
            <a
              href="#"
              :class="{ 'bg-gray-100': selectedTab === 1 }"
              class="inline-block p-4 w-full bg-white hover:text-gray-700 hover:bg-gray-50 rounded-l-lg focus:outline-none"
              @click="selectedTab = 1"
            >Projets</a>
          </li> 
          <li class="w-full">
            <a
              href="#"
              :class="{ 'bg-gray-100': selectedTab === 2 }"
              class="inline-block p-4 w-full bg-white hover:text-gray-700 hover:bg-gray-50 focus:outline-none"
              @click="selectedTab = 2"
            >Fichiers</a>
          </li>
          <li class="w-full">
            <a
              href="#"
              :class="{ 'bg-gray-100': selectedTab === 3 }"
              class="inline-block p-4 w-full bg-white hover:text-gray-700 hover:bg-gray-50 rounded-r-lg focus:outline-none"
              @click="selectedTab = 3"
            >Dashboard</a>
          </li>
        </ul>
      </div>
    </div>

    <div
      v-if="selectedTab === 1"
      class="overflow-x-auto relative shadow-md table-content mt-1"
    >
      <table class="w-full text-sm text-left text-gray-500 mt-4">
        <thead class="text-xs uppercase text-gray-700 bg-gray-50">
          <tr>
            <th
              scope="col"
              class="py-3 px-6"
            >
              Élève
            </th>
            <th
              scope="col"
              class="py-3 px-6"
            >
              Année
            </th>
            <th
              scope="col"
              class="py-3 px-6"
            >
              Formation
            </th>
            <th
              scope="col"
              class="py-3 px-6"
            >
              Projet GITLAB
            </th>
            <th
              scope="col"
              class="py-3 px-6"
            >
              Action
            </th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="projet in repo.projets"
            :key="projet.id_project"
            class="bg-white border-b"
          >
            <th
              scope="row"
              class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap"
            >
              {{ projet.student.lastname }} {{ projet.student.firstname }}
            </th>
            <td class="py-4 px-6">
              {{ projet.student.year }}
            </td>
            <td class="py-4 px-6 uppercase">
              {{ projet.student.formation }}
            </td>
            <td class="py-4 px-6">
              <a
                v-if="projet.info_gitlab != undefined"
                :href="projet.info_gitlab.web_url"
                class="flex items-center text-black font-semibold"
                target="_blank"
              >
                <i class="fa-solid fa-arrow-up-right-from-square" />
                <span class="ml-2">{{ projet.info_gitlab.name }}</span>
              </a>
            </td>
            <td class="py-4 px-6">
              <i
                class="fa-solid fa-trash bg-red-400 hover:bg-red-500 text-white font-bold py-1 px-2 text-xs rounded hover:cursor-pointer ml-1"
                @click="deleteProject(projet.id_project)"
              />
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <div
      v-if="selectedTab === 2"
      class="grid grid-cols-4 gap-6 bg-white mt-4 p-8"
    >
      <CommitForm :form="commitForm" />
      <div class="text-right mt-3 col-span-4 sm:col-span-4">
        <button
          type="submit"
          class="px-4 py-2 rounded-md font-medium text-white bg-purple-500 hover:bg-purple-600"
          @click="addCommit()"
        >
          Ajouter le commit
        </button>
      </div>
    </div>

    <div
      v-if="selectedTab === 3"
    >
      <ul class="flex flex-wrap flex-row-reverse text-sm font-medium text-center mt-2">
        <li class="mr-2">
          <a
            href="#"
            class="inline-block px-3 py-2 hover:text-gray-700 hover:bg-gray-50 text-gray-500 bg-white rounded-md"
            aria-current="page"
            @click="selectedSubTab = 2"
          >
            <i
              class="fa-regular fa-file"
            />
            Fichiers
          </a>
        </li>
        <li class="mr-2">
          <a
            href="#"
            class="inline-block px-3 py-2 hover:text-gray-700 hover:bg-gray-50 text-gray-500 bg-white rounded-md"
            @click="selectedSubTab = 1"
          >
            <i
              class="fa-solid fa-indent"
            />
            Général
          </a>
        </li>
      </ul>

      <div
        v-if="selectedSubTab === 1"
        class="overflow-x-auto relative shadow-md table-content mt-2"
      >
        <Dashboard :projects="repo.projets" />
      </div>

      <div
        v-if="selectedSubTab === 2"
        class="overflow-x-auto relative shadow-md table-content mt-2"
      >
        <DashboardFile
          :projects="repo.projets"
          :columns="repo.file_columns"
          :idrepo="id_group"
        />
      </div>
    </div>
  </div>
</template>

<script>
import APIService from '../services/APIService';
import GitLabService from '../services/GitLabService';
import Multiselect from '@vueform/multiselect';
import CommitForm from '../components/CommitForm.vue';
import Dashboard from '../components/RepositoryDashboard.vue';
import DashboardFile from '../components/RepositoryDashboardFile.vue';
import { useRoute } from 'vue-router';

export default {
    name: 'UserForm',
    components: {
        Multiselect,
        CommitForm,
        Dashboard,
        DashboardFile
    },
    data () {
        return {
            id_group: -1,
            repo: {
                creator: {}
            },
            editMode: false,
            backup: {},
            teachersList: [],
            teachers: [],
            selectedTab: 1,
            selectedSubTab: 1,
            commitForm: {
                action: 'create',
                branch: 'master',
                commitMessage: '',
                selectedFiles: [], // Liste des fichiers à ajouter au commit
                selectedFilesPath: [] // Liste des paths des fichiers à ajouter au commit
            },
            commitActions: [],
            current_user: {}
        };
    },
    created () {
        this.$store.dispatch('user/setLoading', true);

        // Récupération de l'id
        const route = useRoute();
        this.id_group = route.params.id;

        this.loadGroup();
        this.loadUserInfos();

        APIService.get('repository/teacher/all').then(result => {
            this.teachersList = result.data.filter((el) => (el.id_user !== this.repo.creator.id_user)).map((row) => {return {value: row.id_user, id_gitlab: row.id_gitlab, label: row.lastname.toUpperCase() + " " + row.firstname};});
        });
    },
    methods: {
        loadGroup() {
            APIService.get('repository/' + this.id_group).then(result => {
                if (result.message !== null)
                    this.$router.push({ name: 'RepositoriesList' });
                else {
                    this.repo = result.data;
                    this.repo.actif = this.repo.is_open;

                    // Get all necessary infos from gitlab
                    GitLabService.loadRepoInformations(this.repo).then((repo) => {
                        this.repo = repo;
                        this.$store.dispatch('user/setLoading', false);
                    });
                }
                this.teachers = this.repo.users.filter((el) => el.id_user !== this.repo.creator.id_user).map((row) => {return {value: row.id_user, id_gitlab: row.id_gitlab, label: row.lastname.toUpperCase() + " " + row.firstname};});
            });
        },
        loadUserInfos() {
            this.current_user = this.$store.getters['user/getUserInfos'];
        },
        edit() {
            this.backup.repo = Object.assign({}, this.repo);
            this.editMode = true;
        },
        remove() {
            const parentObject = this;

            this.$vfm.show({
                component: 'DeleteModal',
                on: {
                    confirm(close) {
                        parentObject.$store.dispatch('user/setLoading', true);

                        APIService.delete(`repository/${parentObject.id_group}/delete`).then(() => {
                            GitLabService.deleteGroup(parentObject.id_group).then(() => {
                                parentObject.$store.dispatch('user/setLoading', false);
                                parentObject.$toast.success("Groupe n°" + parentObject.id_group + " supprimé. Suppression définitive dans 7 jours sur GitLab");
                                parentObject.$router.push({ name: 'RepositoriesList' });
                            });
                        });

                        close();
                    },
                    cancel(close) {
                        close();
                    }
                },
                slots: {
                    title: "Suppression d'un groupe GitLab",
                    desc: "Souhaitez-vous réellement supprimer ce groupe GITLAB ? (La supppression définitive sur GitLab sera dans 7 jours.)"
                }
            });
        },
        cancelEdition() {
            this.editMode = false;
            this.repo = this.backup.repo;
            this.teachers = this.repo.users.filter((el) => el.id_user !== this.repo.creator.id_user).map((row) => {return {value: row.id_user, id_gitlab: row.id_gitlab, label: row.lastname.toUpperCase() + " " + row.firstname};});
        },
        validateForm () {
            if (this.repo.label_group.trim().length < 1 || this.repo.start_date === null || this.repo.start_date === '' || (this.selectedTab === 2 && this.commitForm.commitMessage === ''))
                return "Veuillez remplir tous les champs obligatoires.";

            if ((this.repo.end_date !== null && this.repo.end_date !== '') && this.repo.start_date > this.repo.end_date)
                return "La date de fin ne peut pas être inférieure à la date de début.";

            return 'ok';
        },
        saveEdition() {
            const validation = this.validateForm();
            if (validation !== "ok")
                return this.$toast.error(validation);

            this.$store.dispatch('user/setLoading', true);

            this.repo.actif = (new Date(this.repo.start_date) <= new Date() && (this.repo.end_date === null || this.repo.end_date === '' || new Date(this.repo.end_date) > new Date()));
            this.editMode = false;

            const payload = {
                label_group: this.repo.label_group,
                start_date: this.repo.start_date,
                end_date: (this.repo.end_date === '') ? null : this.repo.end_date,
                users: [...this.teachers]
            };

            // Add creator if not in list
            if (this.teachers.findIndex((element) => element.value === this.repo.creator.id_user) === -1)
                payload.users.push({value: this.repo.creator.id_user, id_gitlab: this.repo.creator.id_gitlab, label: this.repo.creator.lastname.toUpperCase() + " " + this.repo.creator.firstname});

            APIService.post('/repository/' + this.id_group + '/edit', payload).then(() => {
                this.$store.dispatch('user/setLoading', false);
                this.$toast.success("Les modifications ont été sauvegardées.");
            }).catch(() => {
                this.$store.dispatch('user/setLoading', false);
                this.$toast.error("Erreur lors de la sauvegarde des modifications.");
            });
        },
        deleteProject(id_project) {
            const parentObject = this;

            this.$vfm.show({
                component: 'DeleteModal',
                on: {
                    confirm(close) {
                        parentObject.$store.dispatch('user/setLoading', true);

                        APIService.delete(`repository/${parentObject.id_group}/${id_project}/delete_project`).then(() => {
                            GitLabService.deleteProject(id_project).then(() => {
                                parentObject.$toast.success("Projet n°" + id_project + " supprimé.");
                                parentObject.loadGroup();
                            });
                        });

                        close();
                    },
                    cancel(close) {
                        close();
                    }
                },
                slots: {
                    title: "Suppression d'un projet",
                    desc: "Souhaitez-vous réellement supprimer ce projet ?"
                }
            });
        },
        async createCommitActions() {
            this.commitActions = [];
            const promises = [];

            this.commitForm.selectedFiles.forEach(async (file, index) => {
                const data = {
                    action: this.commitForm.action,
                    file: file,
                    file_path: this.commitForm.selectedFilesPath[index]
                };
                promises.push(GitLabService.getCommitAction(data).then((action) => {
                    this.commitActions.push(action);
                }));
            });

            return Promise.all(promises).then(() => {});
        },
        addCommit() {
            const validation = this.validateForm();

            // Remove duplicated projects in this.repo.projets
            const filtered_projects = [];
            this.repo.projets.forEach((project) => {
                if (filtered_projects.findIndex((el) => el.id_project === project.id_project) === -1)
                    filtered_projects.push(project);
            });

            if (validation !== "ok")
                return this.$toast.error(validation);
            else {
                const error = { valid: 1, error_msg: '' };
                const promises = [];

                this.$store.dispatch('user/setLoading', true);

                this.createCommitActions().then(() => {
                    // Commit sur chaque repo
                    filtered_projects.forEach((project) => {

                        // Création de l'objet content les données nécessaires pour faire la requête
                        const data = {
                            project_id: project.id_project,
                            branch_name: this.commitForm.branch,
                            commit_message: this.commitForm.commitMessage,
                            actions: this.commitActions
                        };

                        promises.push(GitLabService.addCommit(data).then((result) => {
                            error.valid = result.error;
                            error.error_msg = result.error_message;
                        }));
                    });

                    Promise.all(promises).then(() => {
                        if (error.valid === -1)
                            this.$toast.error(error.error_msg);
                        else {
                            this.$toast.success("Le commit a bien été ajouté.");
                            this.resetCommitForm();
                        }

                        this.$store.dispatch('user/setLoading', false);
                    });
                });
            }
        },
        resetCommitForm() {
            this.commitForm.commitMessage = '';
            this.commitForm.selectedFiles = [];
            this.commitForm.selectedFilesPath = [];
        }
    }
};

</script>

<style src="@vueform/multiselect/themes/default.css"></style>
