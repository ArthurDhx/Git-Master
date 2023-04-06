<template>
  <div class="container mx-auto py-8">
    <div class="grid grid-cols-2 gap-6">
      <div class="container max-w-full mx-auto pt-8 pb-3 ml-2">
        <div>
          <h2
            class="text-2xl font-bold text-gray-900 sm:text-3xl mb-4 text-left flex justify-left items-left gap-4"
          >
            Liste des groupes d'élèves
            <div class="text-right">
              <button
                class="rounded-md px-2 py-1 text-sm border border-gray-300 bg-white hover:bg-gray-200 text-gray-600"
                @click="addPupilGroup()"
              >
                <i class="fa-solid fa-plus" />
              </button>
            </div>
          </h2>
        </div>

        <div class="overflow-x-auto relative shadow-md table-content">
          <table class="w-full text-sm text-left text-gray-500">
            <thead class="text-l uppercase text-gray-700 bg-gray-50">
              <tr>
                <th
                  scope="col"
                  class="py-3 px-6 flex flex-row-reverse"
                >
                  <div class="py-2.5 pl-3 flex flex-none">
                    ACTION
                  </div>
                  <div class="flex flex-grow">
                    <input
                      v-model="search"
                      type="text"
                      placeholder="Rechercher un groupe élèves en particulier..."
                      class="bg-white border rounded w-64 py-2 px-3 text-gray-700 text-sm focus:outline-none focus:border-purple-300 flex flex-grow"
                    >
                  </div>
                  <div class="py-2.5 pr-1 flex flex-none">
                    Nom
                  </div>
                </th>
              </tr>
            </thead>

            <tbody>
              <tr
                v-for="pupilgroup in filteredPupilGroups"
                :key="pupilgroup"
                class="bg-white border-b"
                @click="this.pupilgroup = pupilgroup.label_group"
              >
                <th
                  scope="row"
                  class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap hover:font-bold hover:bg-stone-100 flex flex-row-reverse"
                >
                  <div class="flex flex-none">
                    <i
                      class="fa-solid fa-pen-to-square bg-blue-500 hover:bg-blue-600 text-white font-bold py-1 px-2 text-xs rounded hover:cursor-pointer text-align: center;"
                      @click="editPupilGroup(pupilgroup.id_pupil_group)"
                    />
                    <i
                      class="fa-solid fa-trash bg-red-400 hover:bg-red-500 text-white font-bold py-1 px-2 text-xs rounded hover:cursor-pointer ml-1"
                      @click="deletePupilGroup(pupilgroup.id_pupil_group)"
                    />
                  </div>

                  <div
                    class="flex flex-grow"
                    @click="ShowStudentPupilGroup(pupilgroup)"
                  >
                    {{ pupilgroup.label_group }}
                  </div>
                </th>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

      <div class="container max-w-full mx-auto pt-8 pb-3 pr-2">
        <div>
          <h2
            class="text-2xl font-bold text-gray-900 sm:text-3xl mb-5 text-left flex justify-left items-left gap-4"
          >
            Elèves inclus dans : {{ StudentsInGroupTitle }}
          </h2>
        </div>

        <div class="overflow-x-auto relative shadow-md table-content">
          <table class="w-full text-sm text-left text-gray-500">
            <thead class="text-l uppercase text-gray-700 bg-gray-50">
              <tr>
                <th>
                  <div class="py-3 px-4">
                    Prénom
                  </div>
                </th>
                <th
                  scope="col"
                  class="py-3 px-6"
                >
                  <div class="flex flex-row-reverse">
                    <div class="px-3 flex-grow">
                      <input
                        v-model="searchStudent"
                        type="text"
                        placeholder="Rechercher un élève en particulier ..."
                        class="bg-white border rounded w-80 py-2 px-3 text-gray-700 text-sm focus:outline-none focus:border-purple-300"
                      >
                    </div>
                    <div class="py-2.5 flex-none">
                      Nom
                    </div>
                  </div>
                </th>
              </tr>
            </thead>
            <tbody>
              <tr
                v-for="student in filteredStudentsInGroupList"
                :key="student"
                class="bg-white border-b"
              >
                <th
                  scope="row"
                  class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap"
                >
                  {{ student.firstname }}
                </th>
                <th class="py-4 px-6">
                  {{ student.lastname }}
                </th>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import APIService from "../services/APIService";

export default {
    name: "PupilGroups",
    data() {
        return {
            search: "",
            searchStudent: "",
            PupilGroups: [],
            StudentsInGroupList: [],
            StudentsInGroupTitle: ""
        };
    },
    computed: {
        filteredPupilGroups() {
            return this.PupilGroups.filter((el) =>
                el.label_group.toLowerCase().includes(this.search.toLowerCase())
            );
        },

        filteredStudentsInGroupList() {
            return this.StudentsInGroupList.filter((el) =>
                (el.firstname + " " + el.lastname)
                    .toLowerCase()
                    .includes(this.searchStudent.toLowerCase())
            ).sort((a, b) =>
                a.lastname > b.lastname ? 1 : b.lastname > a.lastname ? -1 : 0
            );
        }
    },
    created() {
        this.initTab();
    },
    methods: {
        initTab() {
            this.$store.dispatch('user/setLoading', true);

            APIService.get("pupilgroup/all").then((result) => {
                this.PupilGroups = result.data;
                this.$store.dispatch('user/setLoading', false);
            });
        },
        addPupilGroup() {
            this.$router.push({ name: "PupilGroupCreation" });
        },

        editPupilGroup(id_pupil_group) {
            this.$router.push({
                name: "PupilGroupEdition",
                params: { id: id_pupil_group }
            });
        },

        deletePupilGroup(id_pupil_group) {
            const parentObject = this;

            this.$vfm.show({
                component: 'DeleteModal',
                on: {
                    confirm(close) {
                        parentObject.$store.dispatch('user/setLoading', true),

                        APIService.delete("pupilgroup/delete/" + id_pupil_group).then(() => {
                            parentObject.initTab();
                            parentObject.StudentsInGroupList = [];
                            parentObject.StudentsInGroupTitle = "";
                            parentObject.$toast.success("Le groupe d'élèves a bien été supprimé.");
                        }).catch(() => parentObject.$toast.error("Erreur lors de la suppression du groupe d'élèves."));

                        close();
                    },
                    cancel(close) {
                        close();
                    }
                },
                slots: {
                    title: "Suppression d'un groupe",
                    desc: "Souhaitez-vous réellement supprimer ce groupe d'élèves ?"
                }
            });
        },

        ShowStudentPupilGroup(pupilgroup) {
            this.StudentsInGroupList = pupilgroup.students;
            this.StudentsInGroupTitle = pupilgroup.label_group;
        }
    }
};
</script>
