<template>
  <div class="container max-w-5xl mx-auto py-8">
    <h2 class="text-2xl font-bold text-gray-900 sm:text-3xl mb-4 text-center flex justify-center items-center gap-4">
      {{ type == 'edition' ? 'Édition d\'un étudiant' : 'Création d\'un étudiant' }}
      <div class="text-right mb-1">
        <button
          class="rounded-md px-2 py-1 text-sm border border-gray-300 bg-white hover:bg-gray-200 text-gray-600"
          @click="$router.push({ name: 'StudentsList' })"
        >
          Retour
        </button>
      </div>
    </h2>
    
    <div 
      v-if="type=='edition'"
      class="w-full shadow px-5 py-2 bg-gray-100"
    >
      <div class="relative">
        <div class="flex items-center justify-between">
          <span class="font-medium"> {{ form.firstname }} {{ form.lastname }} </span>
        </div>
      </div>
    </div>

    <div v-if="type=='edition'">
      <div class="mt-6">
        <ul class="hidden text-sm font-medium text-center text-gray-500 rounded-lg divide-x divide-gray-200 shadow sm:flex">
          <li class="w-full">
            <a
              href="#"
              :class="{ 'bg-gray-100': selectedTab === 1 }"
              class="inline-block p-4 w-full bg-white hover:text-gray-700 hover:bg-gray-50 rounded-l-lg focus:outline-none"
              @click="selectedTab = 1"
            >Informations</a>
          </li>
          <li class="w-full">
            <a
              href="#"
              :class="{ 'bg-gray-100': selectedTab === 2 }"
              class="inline-block p-4 w-full bg-white hover:text-gray-700 hover:bg-gray-50 focus:outline-none"
              @click="selectedTab = 2"
            >Liste des projets</a>
          </li>
          <li class="w-full">
            <a
              href="#"
              :class="{ 'bg-gray-100': selectedTab === 3 }"
              class="inline-block p-4 w-full bg-white hover:text-gray-700 hover:bg-gray-50 rounded-r-lg focus:outline-none"
              @click="selectedTab = 3"
            >Dashboard des projets</a>
          </li>
        </ul>
      </div>
    </div>
    <div
      v-if="selectedTab === 1"
      class="w-full shadow p-5 sm:rounded-lg bg-white mt-5"
    >
      <div class="relative">
        <form
          ref="form"
          action="#"
          method="POST"
          @submit="onSubmit"
        >
          <div class="grid grid-cols-4 gap-6">
            <div class="col-span-4 sm:col-span-2">
              <label
                for="first-name"
                class="block text-gray-700 text-sm font-medium mb-2 required_field"
              >Prénom</label>
              <input
                id="first-name"
                v-model="form.firstname"
                type="text"
                name="first-name"
                placeholder="John"
                class="border border-gray-400 rounded w-full py-2 px-3 text-gray-700 text-sm leading-tight focus:outline-none focus:border-purple-300"
              >
            </div>

            <div class="col-span-4 sm:col-span-2">
              <label
                for="last-name"
                class="block text-gray-700 text-sm font-medium mb-2 required_field"
              >Nom</label>
              <input
                id="last-name"
                v-model="form.lastname"
                type="text"
                name="last-name"
                placeholder="Smith"
                class="border border-gray-400 rounded w-full py-2 px-3 text-gray-700 text-sm leading-tight focus:outline-none focus:border-purple-300"
              >
            </div>

            <div class="col-span-4 sm:col-span-2">
              <label
                for="uid-ul"
                class="block text-gray-700 text-sm font-medium mb-2 required_field"
              >UID UL</label>
              <input
                id="uid-ul"
                v-model="form.uid_ul"
                type="text"
                name="uid-ul"
                placeholder="jsmith_4u"
                class="border border-gray-400 rounded w-full py-2 px-3 text-gray-700 text-sm leading-tight focus:outline-none focus:border-purple-300"
              >
            </div>

            <div class="col-span-4 sm:col-span-2">
              <label
                for="email-address"
                class="block text-gray-700 text-sm font-medium mb-2 required_field"
              >Adresse mail</label>
              <input
                id="email-address"
                v-model="form.email"
                type="email"
                name="email-address"
                placeholder="john.smith@exemple.fr"
                class="border border-gray-400 rounded w-full py-2 px-3 text-gray-700 text-sm leading-tight focus:outline-none focus:border-purple-300 required_field"
              >
            </div>

            <div class="col-span-4 sm:col-span-2">
              <label
                for="year"
                class="block text-gray-700 text-sm font-medium mb-2 required_field"
              >Année</label>
              <select
                id="year"
                v-model="form.year"
                name="select-year"
                class="border border-gray-400 rounded w-full py-2 px-3 text-gray-700 text-sm focus:outline-none focus:border-purple-300"
              >
                <option value="">
                  Choisir l'année
                </option>
                <option 
                  v-for="year in years"
                  :key="year.value"
                  :value="year.value"
                >
                  {{ year.label }}
                </option>
              </select>
            </div>

            <div class="col-span-4 sm:col-span-2">
              <label
                for="formation"
                class="block text-gray-700 text-sm font-medium mb-2 required_field"
              >Formation</label>
              <select
                id="formation"
                v-model="form.formation"
                name="select-formation"
                class="border border-gray-400 rounded w-full py-2 px-3 text-gray-700 text-sm focus:outline-none focus:border-purple-300"
              >
                <option value="">
                  Choisir la formation
                </option>
                <option value="fise">
                  FISE
                </option>
                <option value="fisa">
                  FISA
                </option>
              </select>
            </div>

            <div
              v-if="form.formation !== fisaFormationLabel"
              class="col-span-4 sm:col-span-2"
            >
              <label class="block text-gray-700 text-sm font-medium mb-2 required_field">Groupe</label>
              <Multiselect
                id="group"
                v-model="selectedGroup"
                name="select-group"
                :options="groupList"
                :searchable="false"
                :close-on-select="false"
                :show-labels="false"
                placeholder="Choisir un groupe"
                class="multiselect border border-gray-400 rounded w-full py-2 px-3 text-gray-700 text-sm focus:outline-none focus:border-purple-300"
              />
            </div>
          </div>
          <div class="text-right mt-3">
            <button
              class="px-4 py-2 mr-2 rounded-md font-medium text-white bg-gray-400 hover:bg-gray-500"
              @click="$router.push({ name: 'StudentsList' })"
            >
              Retour
            </button>
            <button
              type="submit"
              class="px-4 py-2 rounded-md font-medium text-white bg-purple-500 hover:bg-purple-600"
              style="margin-top: 1em"
            >
              {{ type == "edition" ? "Sauvegarder" : "Créer" }}
            </button>
          </div>
        </form>
      </div>
    </div>
    <div
      v-if="selectedTab === 2 && type=='edition'"
      class="overflow-x-auto relative shadow-md table-content mt-1"
    >
      <div class="overflow-x-auto relative shadow-md table-content mt-5">
        <table class="w-full text-sm text-left text-gray-500">
          <thead class="text-xs text-gray-700 uppercase bg-gray-50">
            <tr>
              <th
                scope="col"
                class="py-3 px-6"
              >
                Nom
              </th>
              <th
                scope="col"
                class="py-3 px-6"
              >
                Date de début
              </th>
              <th
                scope="col"
                class="py-3 px-6"
              >
                Date de fin
              </th>
              <th
                scope="col"
                class="py-3 px-6"
              >
                URL
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
              v-for="repo in projects"
              :key="repo.repo.id_repo"
              class="bg-white border-b"
            >
              <td
                class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap"
              >
                {{ repo.info_gitlab ? repo.info_gitlab.name : '' }}
              </td>
              <td class="py-4 px-6">
                {{ dateTime(repo.repo.start_date) }}
              </td>
              <td 
                v-if="repo.repo.end_date" 
                class="py-4 px-6"
              >
                {{ dateTime(repo.repo.end_date) }}
              </td>
              <td 
                v-else
                class="py-4 px-6 text-center"
              >
                /
              </td>
              <td class="py-4 px-6">
                <a
                  v-if="repo.info_gitlab"
                  :href="repo.info_gitlab.web_url"
                  class="flex items-center text-black font-semibold"
                  target="_blank"
                >
                  <i class="fa-solid fa-arrow-up-right-from-square" />
                </a>
              </td>
              <td class="py-4 px-6">
                <i
                  class="fa-solid fa-trash bg-red-400 hover:bg-red-500 text-white font-bold py-1 px-2 text-xs rounded hover:cursor-pointer ml-1"
                  @click="deleteProject(repo.id_project,repo.repo.id_repo)"
                />
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
    <div
      v-if="selectedTab === 3"
      class="overflow-x-auto relative shadow-md table-content mt-1"
    >
      <Dashboard :projects="projects" />
    </div>
  </div>
</template>

<script>
import APIService from "../services/APIService";
import Multiselect from "@vueform/multiselect";
import Dashboard from '../components/RepositoryDashboard.vue';
import { useRoute } from "vue-router";
import GitLabService from '../services/GitLabService';
import moment from 'moment';

export default {
    name: "StudentForm",
    components: {
        Multiselect,
        Dashboard
    },
    data() {
        return {
            type: "creation",
            form: {},
            selectedGroup: "",
            groupList: [],
            appGroupId: "18",
            fisaFormationLabel: "fisa",
            projects: [],
            selectedTab: 1,
            years: []
        };
    },
    created() {
        const route = useRoute();
        const promises = [];

        if (route.params.id) {
            this.type = "edition";
            this.id_student = route.params.id;
        }

        // Init du formulaire
        this.initForm();

        this.$store.dispatch('user/setLoading', true);

        // Chargement des groupes
        promises.push(APIService.get("classgroup/all").then((result) => {
            this.groupList = result.data.map((row) => {
                return { value: row.id_group, label: row.label_group };
            });
        }));

        // Chargement des infos de l'étudiant
        this.loadInfos();

        Promise.all(promises).then(() => {
            this.$store.dispatch('user/setLoading', false);
        });
    },
    methods: {
        initForm() {
            this.form = {
                firstname: "",
                lastname: "",
                uid_ul: "",
                email: "",
                year: "",
                formation: ""
            };
            this.selectedGroup = "";
        },
        loadInfos() {
            const promises = [];
            APIService.get("student/years/all").then((result) => {
                this.years = result.data.map((row) => {
                    return { value: row.id_year, label: row.label_year };
                });
            });

            // Chargement de l'étudiant si nous sommes en édition
            if (this.type === "edition") {
                promises.push(APIService.get("student/" + this.id_student).then((result) => {
                    this.form = result.data;
                    this.form.year = result.data.years[0].id_year;
                    this.selectedGroup = result.data.class_groups[0].id_group;
                    this.projects = result.data.projets;
                    this.projects.forEach(project => {
                        promises.push(GitLabService.loadProjectInformations(project));
                    });
                }));
            }

            Promise.all(promises).then(() => {
                this.$store.dispatch('user/setLoading', false);
            });
        },
        validateForm () {
            if (this.form.firstname.trim().length < 1 || this.form.lastname.trim().length < 1 || this.form.uid_ul.trim().length < 1 || this.form.email.trim().length < 1
              || this.form.year.toString().trim().length < 1 || this.form.formation.trim().length < 1 || (this.form.formation !== this.fisaFormationLabel && this.selectedGroup.toString().trim().length < 1))
                return "Veuillez remplir tous les champs obligatoires.";

            return 'ok';
        },
        onSubmit(e) {
            e.preventDefault();
            const validation = this.validateForm();
            if (validation !== "ok")
                return this.$toast.error(validation);

            const payload = {
                firstname: this.form.firstname,
                lastname: this.form.lastname,
                uid_ul: this.form.uid_ul,
                email: this.form.email,
                year: this.form.year,
                formation: this.form.formation,
                group: this.form.formation === this.fisaFormationLabel ? this.appGroupId : this.selectedGroup
            };

            this.$store.dispatch('user/setLoading', true);

            // Si nous sommes en création
            if (this.type === "creation") {
                APIService.post("/student/create", payload).then((result) => {
                    this.$store.dispatch('user/setLoading', false);

                    if (result.message === "INSERT_OK") {
                        this.initForm();
                        this.$toast.success('L\'étudiant a bien été créé.');
                    } else if (result.message === "EMAIL_ALREADY_USED") {
                        this.$toast.error('Un étudiant avec la même adresse mail existe déjà.');
                    } else {
                        this.$toast.error('Une erreur est survenue lors de la création de l\'étudiant.');
                    }
                });
            }
            // Si nous sommes en édition
            if (this.type === "edition") {
                APIService.post("/student/" + this.id_student + "/edit", payload).then((result) => {
                    this.$store.dispatch('user/setLoading', false);

                    if (result.message === "UPDATE_OK") {
                        this.$router.push({ name: "StudentsList" });
                        this.$toast.success('L\'étudiant a bien été modifié.');
                    }
                    else {
                        this.$toast.error('Une erreur est survenue lors de la modification de l\'étudiant.');
                    }
                }
                );
            }
        },
        
        deleteProject(id_project, id_repo) {
            const parentObject = this;

            this.$vfm.show({
                component: 'DeleteModal',
                on: {
                    confirm(close) {
                        parentObject.$store.dispatch('user/setLoading', true);
                        const project = parentObject.projects.filter(el => el.id_project === id_project)[0];

                        GitLabService.getUser(parentObject.form.email).then(result => {
                            const id_gitlab = result[0].id;

                            if (project.users.length <= 1) {
                                APIService.delete(`repository/${id_repo}/${id_project}/${parentObject.id_student}/${id_gitlab}/delete_project`).then(() => {
                                    GitLabService.deleteProject(id_project).then((result) => {
                                        if (result.message === "202 Accepted") {
                                            parentObject.$toast.success("Projet n°" + id_project + " supprimé.");
                                            parentObject.loadInfos();
                                        } else {
                                            parentObject.$toast.error("Erreur lors de la suppresion du projet n°" + id_project);
                                        }
                                    });
                                });
                            } else {
                                APIService.delete(`repository/${id_repo}/${id_project}/${parentObject.id_student}/${id_gitlab}/delete_contributor`).then((result) => {
                                    if (result.message === "DELETE_OK") {
                                        parentObject.$toast.success("Élève supprimé du projet n°" + id_project + ".");
                                        parentObject.loadInfos();
                                    } else {
                                        parentObject.$toast.error("Erreur lors de la suppresion de l'élève sur le projet n°" + id_project);
                                    }
                                });
                            }
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
        dateTime(value) {
            return moment(value).format('DD/MM/YYYY HH:mm');
        }     
    }
};
</script>

<style src="@vueform/multiselect/themes/default.css"></style>
