<template>
  <div class="container max-w-3xl mx-auto py-8">
    <h2 class="text-2xl font-bold text-gray-900 sm:text-3xl mb-4 text-center">
      Création d'un groupe GITLAB
    </h2>

    <div class="w-full shadow p-5 sm:rounded-lg bg-white">
      <div class="relative">
        <form
          ref="form"
          @submit.prevent="onSubmit"
        >
          <h2 class="col-span-4 sm:col-span-4 font-bold text-gray-900 sm:text-xl mb-4">
            Initialisation :
          </h2>
          <div class="grid grid-cols-4 gap-6">
            <div class="col-span-4 sm:col-span-2">
              <label
                for="repo-group-name"
                class="block text-gray-700 text-sm font-medium mb-2 required_field"
              >Nom du groupe de repository</label>
              <input
                id="repo-group-name"
                v-model="form.repoGroupName"
                type="text"
                name="repo-group-name"
                placeholder="Repo de CS69"
                class="border border-gray-400 rounded w-full py-2 px-3 text-gray-700 text-sm leading-tight focus:outline-none focus:border-purple-300"
              >
            </div>

            <div class="col-span-4 sm:col-span-2">
              <label
                for="pupil-groups"
                class="block text-gray-700 text-sm font-medium mb-2 required_field"
              >Groupes</label>
              <Multiselect
                id="pupil-groups"
                v-model="selectedGroups"
                :options="pupilGroupsList"
                name="pupil-groups"
                object
                mode="tags"
                placeholder="Choisir des groupes"
                :close-on-select="false"
                class="multiselect border border-gray-400 text-gray-700 text-sm focus:outline-none focus:border-purple-300"
              />
            </div>

            <div class="col-span-4 sm:col-span-2">
              <label class="block text-gray-700 text-sm font-medium mb-2 required_field">Date de début</label>
              <input
                v-model="form.start_date"
                type="datetime-local"
                class="bg-white border rounded w-full py-2 px-3 text-gray-700 text-sm focus:outline-none focus:border-² disabled:bg-gray-100"
              >
            </div>

            <div class="col-span-4 sm:col-span-2">
              <label class="block text-gray-700 text-sm font-medium mb-2">Date de fin</label>
              <input
                v-model="form.end_date"
                type="datetime-local"
                class="bg-white border rounded w-full py-2 px-3 text-gray-700 text-sm focus:outline-none focus:border-purple-300 disabled:bg-gray-100"
              >
            </div>

            <div class="col-span-4 sm:col-span-2">
              <label class="block text-gray-700 text-sm font-medium mb-2">Ajouter des enseignants</label>
              <Multiselect
                id="teacher-list"
                v-model="selectedTeachers"
                :options="teachersList"
                name="teacher-list"
                object
                mode="tags"
                placeholder="Choisir des enseignants"
                :close-on-select="false"
                :searchable="true"
                class="multiselect border border-gray-400 text-gray-700 text-sm focus:outline-none focus:border-purple-300"
              />
            </div>

            <div class="col-span-4 sm:col-span-2">
              <label class="block text-gray-700 text-sm font-medium mb-2">Ajouter des élèves</label>
              <Multiselect
                id="student-list"
                v-model="selectedStudents"
                :options="studentsList"
                name="student-list"
                object
                mode="tags"
                placeholder="Choisir des étudiants"
                :close-on-select="false"
                :searchable="true"
                class="multiselect border border-gray-400 text-gray-700 text-sm focus:outline-none focus:border-purple-300"
              />
            </div>

            <h2 class="col-span-4 sm:col-span-4 font-bold text-gray-900 sm:text-xl mt-4">
              Ajout de fichier :
            </h2>

            <div class="col-span-4 sm:col-span-4">
              <input
                id="checkbox_students"
                v-model="form.multipleStudents"
                type="checkbox"
                class="h-4 w-4 accent-purple-300"
              >
              <label
                for="checkbox_students"
                class="pl-2 text-gray-700 text-sm font-medium"
              >Faire des projets avec un nombre d'étudiants spécifiques</label>
            </div>

            <MultipleStudents
              v-if="form.multipleStudents"
              :form="form"
              :selected-students="getStudents"
            />

            <div class="col-span-4 sm:col-span-2">
              <input
                id="checkbox_commit"
                v-model="form.initialCommit"
                type="checkbox"
                class="h-4 w-4 accent-purple-300"
              >
              <label
                for="checkbox_commit"
                class="pl-2 text-gray-700 text-sm font-medium"
              >Ajout d'un commit à la création</label>
            </div>

            <CommitForm
              v-if="form.initialCommit"
              :form="form"
            />
          </div>

          <div class="text-right mt-3">
            <button
              type="button"
              class="px-4 py-2 border border-gray-300 bg-white hover:bg-gray-200 text-gray-600 font-medium rounded-md mr-2"
              @click="$router.push({ name: 'RepositoriesList' })"
            >
              Retour
            </button>
            <button
              type="submit"
              class="px-4 py-2 rounded-md font-medium text-white bg-purple-500 hover:bg-purple-600"
            >
              Créer
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
import APIService from '../services/APIService';
import GitLabService from '../services/GitLabService';
import Multiselect from '@vueform/multiselect';
import CommitForm from '../components/CommitForm.vue';
import MultipleStudents from '../components/MultipleStudents.vue';

export default {
    name: 'UserForm',
    components: {
        Multiselect,
        CommitForm,
        MultipleStudents
    },
    data () {
        return {
            commit: {
                action: 'create',
                branch: 'master'
            },
            form: {
                start_date: null,
                end_date: null,
                repoGroupName: '',
                initialCommit: false,
                multipleStudents: false,
                commitMessage: '',
                selectedFiles: [], // Liste des fichiers à ajouter au commit
                selectedFilesPath: [], // Liste des paths des fichiers à ajouter au commit
                groupNumber: 1,
                studentsGroup: []
            }, // Le formulaire de la page
            pupilGroupsList: [], // Liste des groupe d'élève de l'app
            selectedGroups: [], // Liste des pupilsGroup select
            selectedFiles: [], // Liste des fichiers à ajouter au commit
            selectedFilesPath: [], // Liste des paths des fichiers à ajouter au commit
            commitActions: [], // Liste des actions du futur commit
            selectedTeachers: [], // Liste des enseignants select
            selectedStudents: [], // Liste des étudiants select
            teachersList: [], // Liste des enseignants de l'app
            studentsList: [] // Liste des étudiants de l'app
        };
    },
    computed: {
        getStudents() {
        // get students and remove a level of array : [[]] => []
            const studentsFromGroups = this.selectedGroups.flatMap(element => element.students);
            this.selectedStudents.map(student => studentsFromGroups.push(student));
            return studentsFromGroups;
        }
    },
    created () {
        this.$store.dispatch('user/setLoading', true);

        const promises = [];

        // Chargement des pupilsGroup
        promises.push(APIService.get('pupilsGroup').then(result => {
            this.pupilGroupsList = result.data.map((row) => { return { value: row.id_pupil_group, label: row.label_group, students: row.students}; });
            this.$store.dispatch('user/setLoading', false);
        }));

        promises.push(APIService.get('student/all').then(result => {
            this.studentsList = result.data.map((row) => {return {value: row.id, label: row.lastname + " " + row.firstname, email: row.email, id: row.id, firstname: row.firstname, lastname: row.lastname};});
        }));

        promises.push(APIService.get('repository/teacher/all').then(result => {
            this.teachersList = result.data.map((row) => {return {value: row.id_user, label: row.lastname.toUpperCase() + " " + row.firstname};});
        }));

        Promise.all(promises).then(() => {
            this.$store.dispatch('user/setLoading', false);
        });
    },
    methods: {
        initForm() {
            this.form = {
                name: '',
                start_date: null,
                end_date: null
            };
            this.selectedGroups = [];
            this.selectedFiles = [];
            this.selectedFilesPath = [];
            this.commitActions = [];
            this.selectedTeachers = [];
            this.selectedStudents = [];
        },

        validateForm () {
            if (this.form.repoGroupName.trim().length < 1 || this.form.start_date === null || this.form.start_date === '' || this.selectedGroups.length === 0
          || (this.form.initialCommit && this.form.commitMessage === ''))
                return "Veuillez remplir tous les champs obligatoires.";

            if ((this.form.end_date !== null && this.form.end_date !== '') && this.form.start_date > this.form.end_date)
                return "La date de fin ne peut pas être inférieure à la date de début.";

            return 'ok';
        },

        saveFile() {
            const file = event.target.files[0];
            const existingFile = this.selectedFiles.find((f) => f.name === file.name && f.lastModified === file.lastModified);
            if (file && !existingFile && !this.selectedFiles.includes(file)) {
                this.selectedFiles.push(file);
                this.selectedFilesPath.push(file.name);
            }
        },

        async createCommitActions() {
            this.commitActions = [];
            const promises = [];

            this.form.selectedFiles.forEach((file, index) => {
                const data = {
                    action: this.commit.action,
                    file: file,
                    file_path: this.form.selectedFilesPath[index]
                };
                promises.push(GitLabService.getCommitAction(data).then((action) => {
                    this.commitActions.push(action);
                }));
            });

            return Promise.all(promises).then(() => {});
        },

        isUserAdmin() {
            return this.$store.getters['user/isUserAdmin'];
        },

        getUserInfos() {
            return this.$store.getters['user/getUserInfos'];
        },

        onSubmit() {
            const validation = this.validateForm();
            if (validation !== "ok")
                return this.$toast.error(validation);

            this.$store.dispatch('user/setLoading', true);

            const payload = {
                name: this.form.repoGroupName.replaceAll(' ', ''),
                start_date: this.form.start_date,
                end_date: this.form.end_date,
                pupilsGroups: this.selectedGroups.map(item => { return item["value"] ;}),
                teachers: this.selectedTeachers.map(item => { return item["value"];}),
                students: this.selectedStudents.map(item => { return item["value"];}),
                studentsGroup: this.form.studentsGroup,
                id: null
            };

            this.createCommitActions().then(() => {
                // Crée le groupe sur gitlab et récupère son id
                GitLabService.createGroup(payload).then(result => {
                    if (result.error === -1) {
                        this.$store.dispatch('user/setLoading', false);
                        return this.$toast.error(result.error_message);
                    }

                    payload.id = result.data.id;

                    // Création du groupe dans notre bd + création des repo pour chaque membre du groupe
                    APIService.post('/repository/create', payload).then(result => {
                        if (result.message === "INSERT_OK") {
                            // Si nécessaire, ajout du commit demandé par l'utilisateur
                            if (this.form.initialCommit) {
                                // Récupération des id des repos du groupe
                                APIService.get('repository/' + payload.id).then(result => {
                                    // Suppression des projets dupliqués dans les projets retournés
                                    const projects = result.data.projets;
                                    const filtered_projects = [];

                                    projects.forEach((project) => {
                                        if (filtered_projects.findIndex((el) => el.id_project === project.id_project) === -1)
                                            filtered_projects.push(project);
                                    });

                                    const error = { valid: 1, error_msg: '' };
                                    const promises = [];

                                    // Commit sur chaque repo
                                    filtered_projects.forEach((project) => {
                                        // Création de l'objet content les données nécessaires pour faire la requête
                                        const data = {
                                            project_id: project.id_project,
                                            branch_name: this.commit.branch,
                                            commit_message: this.form.commitMessage,
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
                                        else
                                            this.$toast.success("Le commit a bien été ajouté.");
                                        this.$store.dispatch('user/setLoading', false);
                                    });

                                    this.$toast.success("La création a été effectuée.");
                                    this.$router.push({ name: 'RepositoriesList' });
                                });
                            } else {
                                this.$toast.success("La création a été effectuée.");
                                this.$router.push({ name: 'RepositoriesList' });
                            }
                        }
                    });
                });
            });
        }
    }
};

</script>

<style src="@vueform/multiselect/themes/default.css"></style>
