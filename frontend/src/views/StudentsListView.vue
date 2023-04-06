<template>
  <div class="container max-w-5xl mx-auto py-8">
    <h2
      class="
        text-2xl
        font-bold
        text-gray-900
        sm:text-3xl
        mb-4
        text-center
        flex
        justify-center
        items-center
        gap-4
      "
    >
      Étudiants
      <div class="text-right mb-1">
        <button
          class="
            rounded-md
            px-2
            py-1
            text-sm
            border border-gray-300
            bg-white
            hover:bg-gray-200
            text-gray-600
          "
          @click="addStudent()"
        >
          <i class="fa-solid fa-plus" />
        </button>
      </div>
    </h2>

    <div class="w-full shadow px-5 py-2 bg-gray-100">
      <div class="relative">
        <div class="flex items-center justify-between">
          <p class="font-medium">
            Filtres
          </p>

          <button
            class="
              px-4
              py-2
              border border-gray-300
              bg-white
              hover:bg-gray-200
              text-gray-600 text-sm
              font-medium
              rounded-md
            "
            @click="reset()"
          >
            Réinitialiser les filtres
          </button>
        </div>

        <div
          class="
            grid
            md:grid-cols-3
            grid-cols-2
            gap-3
            mt-2
            border-t border-gray-300
            py-3
          "
        >
          <div>
            <span class="text-gray-700 block text-sm font-medium mb-2">Filtrage par nom</span>
            <input
              v-model="filtre_search"
              type="text"
              placeholder="Rechercher par nom.."
              class="
                bg-white
                border
                rounded
                w-full
                py-2
                px-3
                text-gray-700 text-sm
                focus:outline-none focus:border-purple-300
              "
            >
          </div>

          <div>
            <span class="text-gray-700 block text-sm font-medium mb-2">Filtrage par groupe GITLAB</span>
            <select
              id="groupes"
              v-model="fGroups"
              class="
                bg-white
                border
                rounded
                w-full
                py-2
                px-3
                text-gray-700 text-sm
                focus:outline-none focus:border-purple-300
              "
            >
              <option value="null">
                /
              </option>
              <option
                v-for="group in StudentGroupList"
                :key="group"
                class=""
              >
                {{ group.label_group }}
              </option>
            </select>
          </div>

          <div>
            <span class="text-gray-700 block text-sm font-medium mb-2">Filtrage par formation</span>
            <select
              v-model="filtre_formation"
              class="
                border border-gray-200
                rounded
                w-full
                py-2
                px-3
                text-gray-700 text-sm
                focus:outline-none focus:border-purple-300
              "
            >
              <option value="all">
                /
              </option>
              <option value="fise">
                FISE
              </option>
              <option value="fisa">
                FISA
              </option>
            </select>
          </div>

          <div>
            <span class="text-gray-700 block text-sm font-medium mb-2">Filtrage par année</span>
            <select
              v-model="filtre_annee"
              class="
                border border-gray-200
                rounded
                w-full
                py-2
                px-3
                text-gray-700 text-sm
                focus:outline-none focus:border-purple-300
              "
            >
              <option value="all">
                /
              </option>
              <option
                v-for="year in yearsList"
                :key="year.id_year"
                :value="year.id_year"
                class=""
              >
                {{ year.label_year }}
              </option>
            </select>
          </div>
        </div>
      </div>
    </div>

    <div class="text-right mt-4">
      <div>
        <button
          class="
          px-4
          py-2
          border border-gray-300
          bg-white
          hover:bg-gray-200
          text-gray-600 text-right
          font-medium
          rounded-md
        "
        >
          <a
            download="studentTemplate.ods"
            href="/files/template_student.ods"
          >
            <i class="fa-solid fa-download" />
            Template
          </a>
        </button>
        <input
          class="ml-2"
          type="file"
          @change="onFileChange"
        >
      </div>
    </div>

    <div class="overflow-x-auto relative shadow-md table-content mt-3">
      <table class="w-full text-sm text-left text-gray-500">
        <thead class="text-xs uppercase text-gray-700 bg-gray-50">
          <tr>
            <th
              scope="col"
              class="py-3 px-6"
            >
              Prénom
            </th>
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
              Groupes
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
            v-for="student in filteredStudents"
            :key="student"
            class="bg-white border-b"
          >
            <th
              scope="row"
              class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap"
            >
              {{ student.firstname }}
            </th>
            <td class="py-4 px-6">
              {{ student.lastname }}
            </td>
            <td class="py-4 px-6">
              {{ student.years[0].label_year }}
            </td>
            <td class="py-4 px-6 uppercase">
              {{ student.formation }}
            </td>
            <td 
              v-if="student.pupil_groups.length > 0"
              class="py-4 px-6"
            >
              <span
                class="cpointer hover:text-black"
                @click="openModalGroups(student.id)"
              >Voir les groupes</span>
              <div
                :id="'groups' + student.id"
                class="modal-bg-groups dnone"
                @click="closeModalGroups(event)"
              >
                <div class="modal-groups">
                  <span class="cpointer modal-close">&#10006;</span>
                  <div class="modal-content">
                    <p
                      v-for="projet in student.pupil_groups"
                      :key="projet"
                    >
                      <a
                        target="_blank"
                        class="hover:font-bold"
                        :href="
                          $router.resolve({
                            name: 'PupilGroupEdition',
                            params: { id: projet.id_pupil_group },
                          }).href
                        "
                      >- {{ projet.label_group }}</a>
                    </p>
                  </div>
                </div>
              </div>
            </td>
            <td 
              v-else
              class="py-4 px-6"
            >
              Aucun groupe
            </td>
            <td class="py-4 px-6">
              <i
                class="
                  fa-solid fa-pen-to-square
                  bg-blue-500
                  hover:bg-blue-600
                  text-white
                  font-bold
                  py-1
                  px-2
                  text-xs
                  rounded
                  hover:cursor-pointer
                "
                @click="editStudent(student.id)"
              />
              <i
                class="
                  fa-solid fa-trash
                  bg-red-400
                  hover:bg-red-500
                  text-white
                  font-bold
                  py-1
                  px-2
                  text-xs
                  rounded
                  hover:cursor-pointer
                  ml-1
                "
                @click="deleteStudent(student.id)"
              />
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
import APIService from "../services/APIService";
import * as XLSX from "xlsx";

export default {
    name: "StudentsList",
    data() {
        return {
            filtre_search: "",
            filtre_formation: "all",
            filtre_annee: "all",
            fGroups: "null",
            StudentsList: [],
            StudentGroupList: [],
            yearsList: []
        };
    },
    computed: {
        filteredStudents() {
            return this.StudentsList.filter((el) =>
                (el.firstname + " " + el.lastname)
                    .toLowerCase()
                    .includes(this.filtre_search.toLowerCase())
            )
                .filter(
                    (el) =>
                        el.formation === this.filtre_formation ||
            this.filtre_formation === "all"
                )
                .filter(
                    (el) => el.years[0].id_year === this.filtre_annee || this.filtre_annee === "all"
                )
                .filter((student) => {
                    if (this.fGroups === "null") return true;

                    if (student.projets.length === 0) return false;

                    for (const i in student.projets) {
                        if (student.projets[i].repo.label_group === this.fGroups)
                            return true;
                    }

                    return false;
                })
                .sort((a, b) =>
                    a.lastname > b.lastname ? 1 : b.lastname > a.lastname ? -1 : 0
                );
        }
    },
    created() {
        this.$store.dispatch('user/setLoading', true);

        this.initTab();
    },
    methods: {
        initTab() {
            const promises = [];

            promises.push(APIService.get("student/all").then((result) => {
                this.StudentsList = result.data;
            }));

            promises.push(APIService.get("repository/").then((result) => {
                this.StudentGroupList = result.data;
            }));

            promises.push(APIService.get("student/years/all").then((result) => {
                this.yearsList = result.data;
            }));
          
            Promise.all(promises).then(() => {
                this.$store.dispatch('user/setLoading', false);
            });
        },
        reset() {
            (this.filtre_search = ""), (this.filtre_formation = "all");
            this.filtre_annee = "all";
            this.fGroups = "null";
        },
        editStudent(student_id) {
            this.$router.push({ name: "StudentEdition", params: { id: student_id } });
        },
        addStudent() {
            this.$router.push({ name: "StudentCreation" });
        },
        openModalGroups(id) {
            document.getElementById("groups" + id).classList.remove("dnone");
        },
        closeModalGroups() {
            if (event.target.classList.contains("modal-bg-groups")) {
                event.target.classList.add("dnone");
            } else if (event.target.classList.contains("modal-close")) {
                event.target.parentNode.parentNode.classList.add("dnone");
            }
        },
        deleteStudent(id) {
            const parentObject = this;

            this.$vfm.show({
                component: 'DeleteModal',
                on: {
                    confirm(close) {
                        parentObject.$store.dispatch('user/setLoading', true);

                        APIService.delete("student/delete/" + id).then(() => {
                            parentObject.initTab();
                            parentObject.$toast.success("L'étudiant a bien été supprimé.");
                        }).catch(() => parentObject.$toast.error("Erreur lors de la suppression de l'élève."));

                        close();
                    },
                    cancel(close) {
                        close();
                    }
                },
                slots: {
                    title: "Suppression d'un étudiant",
                    desc: "Souhaitez-vous réellement supprimer cet étudiant ?"
                }
            });
        },
        onFileChange(event) {
            this.$store.dispatch('user/setLoading', true);

            this.file = event.target.files ? event.target.files[0] : null;
            if (this.file) {
                const reader = new FileReader();

                reader.onload = (e) => {
                    /* Parse data */
                    const bstr = e.target.result;
                    const wb = XLSX.read(bstr, {
                        type: "binary",
                        cellDates: true,
                        dateNF: "yyyy/mm/dd;@"
                    });
                    /* Get first worksheet */
                    const wsname = wb.SheetNames[0];
                    const ws = wb.Sheets[wsname];
                    /* Convert array of arrays */
                    const data = XLSX.utils.sheet_to_json(ws, { header: 1 });
                    data.shift();
                    APIService.post('/student/creates', data).then(result => {
                        if (result.message === "INSERT_OK") {
                            this.$toast.success("Tous les étudiants ont bien été importé");
                            this.initTab();
                        } else if (result.message === "EMAIL_ALREADY_USED")
                            this.$toast.error("L'email" + result.data + " est déjà utilisée, aucun étudiant n'a été ajouté");
                        this.$store.dispatch('user/setLoading', false);
                    });
                };
                reader.readAsBinaryString(this.file);
            }
            this.$router.push({ name: "StudentsList" });
        }
    }
};
</script>

