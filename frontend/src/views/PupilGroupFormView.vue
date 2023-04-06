<template>
  <div class="container max-w-3xl mx-auto py-8">
    <h2 class="text-2xl font-bold text-gray-900 sm:text-3xl mb-4 text-center">
      {{
        type == "edition"
          ? "Édition d'un groupe d'élèves"
          : "Création d'un groupe d'élèves"
      }}
    </h2>

    <div class="w-full shadow p-5 sm:rounded-lg bg-white">
      <div class="relative">
        <form
          ref="form"
          @submit.prevent="onSubmit"
        >
          <div class="col-span-4 sm:col-span-2">
            <label
              for="label_group"
              class="block text-gray-900 text-m font-medium mb-2 font-bold"
            >Nom du groupe<abbr class="px-1 text-purple-500">*</abbr></label>

            <input
              id="label_group"
              v-model="form.label_group"
              type="text"
              name="label_group"
              placeholder="Ex : &laquo; Les apprentis &raquo;"
              class="border border-gray-400 rounded w-full py-2 px-3 text-gray-700 text-sm leading-tight focus:outline-none focus:border-purple-300"
            >
          </div>

          <h1 class="py-4">
            A présent, veuillez sélectionner la méthode par laquelle ajouter
            et/ou retirer des élèves au groupe.
            <select
              id="method"
              v-model="form.method"
              name="select-method"
              :disabled="type == 'edition'"
              class="border border-gray-400 rounded w-full py-2 px-3 text-gray-700 text-sm focus:outline-none focus:border-purple-300"
              :class="{ 'bg-gray-200': type == 'edition' }"
              @change="resetChecked()"
            >
              <option value="">
                Chosir une méthode
              </option>
              <option value="StudentsList">
                Liste d'élèves
              </option>
              <option value="ClassGroups">
                Liste de formations
              </option>
              <option value="EmailsList">
                Liste de mails
              </option>
            </select>
            <span class="underline">Attention</span>&nbsp;: il est à noter qu'à
            chaque changement de la méthode, les éléments cochés précédemment ne
            sont PAS conservés !
          </h1>

          <div
            v-if="
              form.method == creationMethods.students ||
                form.method == creationMethods.classgroups
            "
            class="container max-w-full mx-auto pt-1 pb-3 pr-2"
          >
            <div>
              <h2
                class="text-xl font-bold text-gray-900 sm:text-xl mb-2 text-left flex justify-left items-left gap-4"
              >
                <p v-if="form.method == creationMethods.students">
                  Liste des élèves disponibles
                </p>
                <p v-if="form.method == creationMethods.classgroups">
                  Liste des formations disponibles
                </p>
              </h2>
              <h3
                class="text-l text-gray-900 sm:text-l mb-4 text-left flex justify-left items-left gap-4"
              >
                <p v-if="form.method == creationMethods.students">
                  Veuillez cocher les élèves à inclure dans le groupe.
                </p>
                <p v-if="form.method == creationMethods.classgroups">
                  Veuillez cocher les formations à inclure au groupe.
                </p>
              </h3>
            </div>

            <div
              v-if="form.method != ''"
              class="overflow-x-auto relative shadow-md table-content"
            >
              <table class="w-full text-sm text-left text-gray-500">
                <thead class="text-m uppercase text-gray-700 bg-gray-50">
                  <tr v-if="form.method == creationMethods.students">
                    <th
                      scope="col"
                      class="py-2.5 px-2 w-12"
                    >
                      <div class="form-check">
                        <input
                          v-model="checked_all"
                          type="checkbox"
                          class="w-4 h-4 text-blue-600 bg-gray-100 rounded border-gray-300 focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-800 focus:ring-2 dark:bg-gray-700 dark:border-gray-600"
                          @click="checkALL(StudentsList)"
                        >
                      </div>
                    </th>
                    <th
                      scope="col"
                      class="py-2.5"
                    >
                      Prénom
                    </th>
                    <th
                      scope="col"
                      class="py-2.5"
                    >
                      Nom
                    </th>
                    <div class="px-3 py-1">
                      <input
                        v-model="searchStudent"
                        type="text"
                        placeholder="Rechercher un élève en particulier..."
                        class="bg-white border rounded w-full py-2 px-3 text-gray-700 text-sm text-bold focus:outline-none focus:border-purple-300"
                      >
                    </div>
                  </tr>
                  <tr v-if="form.method == creationMethods.classgroups">
                    <th
                      scope="col"
                      class="py-3 px-2 w-12"
                    >
                      <div class="form-check">
                        <input
                          v-model="checked_all"
                          type="checkbox"
                          class="w-4 h-4 text-blue-600 bg-gray-100 rounded border-gray-300 focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-800 focus:ring-2 dark:bg-gray-700 dark:border-gray-600"
                          @click="checkALL(ClassGroupsList)"
                        >
                      </div>
                    </th>
                    <th
                      scope="col"
                      class="py-2.5"
                    >
                      Nom
                    </th>
                    <div class="px-3 py-1">
                      <input
                        v-model="searchClassGroups"
                        type="text"
                        placeholder="Rechercher une formation en particulier..."
                        class="bg-white border rounded w-full py-2 px-3 text-gray-700 text-sm text-bold focus:outline-none focus:border-purple-300"
                      >
                    </div>
                  </tr>
                </thead>
                <tbody>
                  <tr
                    v-for="student in filteredStudentsList"
                    :key="student.id"
                    class="bg-white border-b"
                  >
                    <td v-if="form.method == creationMethods.students">
                      <div class="form-check px-2">
                        <input
                          v-model="checked"
                          type="checkbox"
                          :value="student.id"
                          class="w-4 h-4 text-blue-600 bg-gray-100 rounded border-gray-300 focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-800 focus:ring-2 dark:bg-gray-700 dark:border-gray-600"
                        >
                      </div>
                    </td>
                    <td
                      v-if="form.method == creationMethods.students"
                      scope="row"
                      class="py-4 font-medium text-gray-900 whitespace-nowrap"
                    >
                      {{ student.firstname }}
                    </td>
                    <td
                      v-if="form.method == creationMethods.students"
                      class="py-4"
                    >
                      {{ student.lastname }}
                    </td>
                  </tr>
                  <tr
                    v-for="classGroup in filteredClassGroupsList"
                    :key="classGroup.id_group"
                    class="bg-white border-b"
                  >
                    <td v-if="form.method == creationMethods.classgroups">
                      <div class="form-check px-2">
                        <input
                          v-model="checked"
                          type="checkbox"
                          :value="classGroup.id_group"
                          class="w-4 h-4 text-blue-600 bg-gray-100 rounded border-gray-300 focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-800 focus:ring-2 dark:bg-gray-700 dark:border-gray-600"
                        >
                      </div>
                    </td>
                    <td
                      v-if="form.method == creationMethods.classgroups"
                      scope="row"
                      class="py-4 font-medium text-gray-900 whitespace-nowrap"
                    >
                      {{ classGroup.label_group }}
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
          <div
            v-if="form.method == creationMethods.emails"
            class="container max-w-full mx-auto pt-1 pb-3 pr-2"
          >
            <h2 class="block text-gray-900 text-m mb-2 font-bold">
              <p>
                Veuillez entrer une liste de mail respectant ce format
                :&nbsp;"<i> email1 <b>;</b> email2 <b>;</b> ...</i>"
              </p>
            </h2>
            <div class="py -2">
              <input
                id="emailsList"
                v-model="form.emailsList"
                type="text"
                name="emailsList"
                placeholder="Ex : maxime.istace@telecomnancy.net ; arthur.duhoux@telecomnancy.net ; ..."
                class="border border-gray-400 rounded w-full py-2 px-3 text-gray-700 text-sm leading-tight focus:outline-none focus:border-purple-300"
              >
            </div>
          </div>

          <div class="text-right">
            <button
              type="button"
              class="px-4 py-2 mr-2 rounded-md font-medium text-white bg-gray-400 hover:bg-gray-500"
              @click="$router.push({ name: 'PupilGroups' })"
            >
              Retour
            </button>
            <button
              type="submit"
              class="px-4 py-2 rounded-md font-medium text-white bg-purple-500 hover:bg-purple-600 mt-3"
            >
              {{ type == "edition" ? "Sauvegarder" : "Créer" }}
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
import APIService from "../services/APIService";
import { useRoute } from "vue-router";

export default {
    name: "PupilGroupForm",
    data() {
        return {
            type: "creation",
            searchClassGroups: "",
            searchStudent: "",
            creationMethods: {
                classgroups: "ClassGroups",
                students: "StudentsList",
                emails: "EmailsList"
            },
            form: {}, // Le formulaire de la page
            StudentsList: [], // Liste des étudiants
            ClassGroupsList: [], // Liste des formations
            checked_all: false,
            checked: [] // Liste les éléments sélectionnés
        };
    },

    computed: {
        filteredStudentsList() {
            return this.StudentsList.filter((el) =>
                (el.firstname + " " + el.lastname)
                    .toLowerCase()
                    .includes(this.searchStudent.toLowerCase())
            ).sort((a, b) =>
                a.lastname > b.lastname ? 1 : b.lastname > a.lastname ? -1 : 0
            );
        },

        filteredClassGroupsList() {
            return this.ClassGroupsList.filter((el) =>
                el.label_group
                    .toLowerCase()
                    .includes(this.searchClassGroups.toLowerCase())
            );
        }
    },
    created() {
    // Init du formulaire et du tableau
        this.initForm();
        this.initTab();

        // Récupération de l'id dans le cas où on est en édition
        const route = useRoute();
        if (route.params.id) {
            this.type = "edition";
            this.id_pupil_group = route.params.id;
        }

        // Chargement du pupilgroup si nous sommes en édition
        if (this.type === "edition") {
            APIService.get("pupilgroup/" + this.id_pupil_group).then((result) => {
                this.form = result.data;
                this.form.method = "StudentsList";
                // Pour chaque étudiant, on coche les étudiants
                for (const s in this.form.students) {
                    this.checked.push(this.form.students[s].id);
                }
            });
        }
    },
    methods: {
        initForm() {
            this.form = {
                label_group: "",
                method: "",
                emailsList: ""
            };
        },
        initTab() {
            // Tableau listant les élèves
            APIService.get("student/all").then((result) => {
                this.StudentsList = result.data;
            });

            // Tableau listant les formations
            APIService.get("classgroup/all").then((result) => {
                this.ClassGroupsList = result.data;
            });
        },

        // Réinitialisation des checked à chaque changement de méthode
        resetChecked() {
            this.checked = [];
            this.checked_all = false;
        },

        //Select all Students or Classgroups
        checkALL(list_checked) {
            this.checked = [];
            if (!this.checked_all) {
                for (const i in list_checked) {
                    if (this.form.method === this.creationMethods.students) {
                        this.checked.push(list_checked[i].id);
                    } else if (this.form.method === this.creationMethods.classgroups) {
                        this.checked.push(list_checked[i].id_group);
                    }
                }
            }
        },

        validateForm() {
            if (this.form.label_group.trim().length < 1)
                return "Veuillez remplir tous les champs obligatoires.";

            return "ok";
        },

        EmailReport(){
        },

        onSubmit(e) {
            e.preventDefault();

            const validation = this.validateForm();
            if (validation !== "ok") return this.$toast.error(validation);

            // Si nous sommes en création
            if (this.type === "creation") {
                const payload = {
                    label_group: this.form.label_group,
                    selected_method: this.form.method,
                    list_id: this.checked,
                    emails_list: this.form.emailsList
                };
                
                this.$store.dispatch("user/setLoading", true);
                APIService.post("/pupilgroup/create", payload).then((result) => {
                    if (result.message === "INSERT_OK") {
                        this.$toast.success("Le groupe d'élèves a bien été créé.");
                        this.$router.push({ name: "PupilGroups" });
                    } else if (result.message === "LABEL_GROUP_ALREADY_USED")
                        this.$toast.error("Le nom du groupe est déjà utilisé. Veuillez en choisir un autre.");
                    else if (this.selected_method === "EmailsList") {
                        this.EmailReport();
                    }

                    this.$store.dispatch("user/setLoading", false);
                });
            }

            // Si nous sommes en édition
            if (this.type === "edition") {
                const payload = {
                    label_group: this.form.label_group,
                    list_id: this.checked
                };

                this.$store.dispatch("user/setLoading", true);

                APIService.post(
                    "pupilgroup/" + this.id_pupil_group + "/edit",
                    payload
                ).then((result) => {
                    if (result.message === "EDIT_OK") {
                        this.$toast.success("Le groupe d'élèves a bien été modifié.");
                        this.$router.push({ name: "PupilGroups" });
                    } else if (result.message === "LABEL_GROUP_ALREADY_USED")
                        this.$toast.error(
                            "Le nom du groupe est déjà utilisé par un autre groupe. Veuillez en choisir un autre."
                        );

                    this.$store.dispatch("user/setLoading", false);
                });
            }
        }
    }
};
</script>
