<template>
  <div>
    <table class="w-full text-sm text-left text-gray-500">
      <thead class="text-xs uppercase text-gray-700 bg-gray-50">
        <tr>
          <th
            scope="col"
            class="py-3 px-6"
          >
            Projet GITLAB
          </th>

          <th
            v-for="column in columns"
            :key="column.id"
            scope="col"
            class="py-3 px-6 text-center"
          >
            {{ column.file_path }}
            <i
              class="fa-solid fa-trash bg-red-400 hover:bg-red-500 text-white font-bold py-1 px-2 text-xs rounded hover:cursor-pointer ml-1"
              @click="deleteFilter(column.id)"
            />
          </th>
          <th
            scope="col"
            class="py-3 px-6 text-right"
          >
            <button
              class="rounded-md px-2 py-1 text-sm border border-gray-300 bg-white hover:bg-gray-200 text-gray-600"
              @click="addFilter()"
            >
              <i class="fa-solid fa-plus" />
            </button>
          </th>
        </tr>
      </thead>
      <tbody>
        <tr
          v-for="project in projects"
          :key="project.id_project"
          class="bg-white border-b"
        >
          <td class="py-4 px-6">
            <a
              v-if="project.info_gitlab != undefined"
              :href="project.info_gitlab.web_url"
              class="flex items-center text-black font-semibold"
              target="_blank"
            >
              <i class="fa-solid fa-arrow-up-right-from-square" />
              <span class="ml-2">{{ project.info_gitlab.name }}</span>
            </a>
          </td>

          <td
            v-for="column in columns"
            :key="column.id"
            class="py-4 px-6 text-center"
          >
            <i
              v-if="isFileThere(project, column.file_path)"
              class="fa-regular fa-circle-check text-green-600"
            />
            <i
              v-else
              class="fa-regular fa-circle-xmark text-red-400"
            />
          </td>
          <td />
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import APIService from '../services/APIService';

export default {
    name: 'DashboardComponent',
    props: {
        projects: {
            type: Array,
            required: true
        },
        columns: {
            type: Array,
            required: true
        },
        idrepo: {
            type: String,
            required: true
        }
    },
    methods: {
        isFileThere(project, file_path) {
            return project.files.some( file => file.path === file_path && file.type === "blob");
        },
        deleteFilter(id) {
            this.$store.dispatch('user/setLoading', true);

            APIService.delete(`repository/delete_filter/${id}`).then(() => {
                const objWithIdIndex = this.columns.findIndex((obj) => obj.id === id);
                this.columns.splice(objWithIdIndex, 1);
                this.$store.dispatch('user/setLoading', false);
            });
        },
        addFilter() {
            const parentObject = this;

            this.$vfm.show({
                component: 'InputModal',
                on: {
                    close(close) {
                        close();
                    },
                    confirm(close, text) {
                        parentObject.$store.dispatch('user/setLoading', true);

                        const payload = {
                            file_path: text
                        };

                        APIService.post(`repository/${parentObject.idrepo}/add_filter`, payload).then((response) => {
                            parentObject.columns.push({
                                id: response.message.id,
                                file_path: response.message.file_path
                            });

                            parentObject.$store.dispatch('user/setLoading', false);
                            close();
                        });
                    }
                },
                slots: {
                    title: "Ajout d'un filtre",
                    desc: "Veuillez préciser le path du fichier attendu, sous la forme : nom_dossier/nom_sous_dossier/nom_fichier.extension"
                }
            });
        }
    }
};
</script>
