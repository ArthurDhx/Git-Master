<template>
  <div>
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
            <span class="text-gray-700 block text-sm font-medium mb-2">Filtrage par nombre de fichiers</span>
            <input
              v-model="filtre_fichiers"
              type="number"
              placeholder="Rechercher par nombre de fichiers"
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
            <span class="text-gray-700 block text-sm font-medium mb-2">Filtrage par nombre de commits</span>
            <input
              v-model="filtre_commits"
              type="number"
              placeholder="Rechercher par nombre de commits"
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
        </div>
      </div>
    </div>
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
            scope="col"
            class="py-3 px-6"
          >
            Dernière modification
          </th>
          <th
            scope="col"
            class="py-3 px-6"
          >
            Fichiers
          </th>
          <th
            scope="col"
            class="py-3 px-6"
          >
            Commits
          </th>
          <th
            scope="col"
            class="py-3 px-6"
          >
            Branches
          </th>
          <th
            scope="col"
            class="py-3 px-6"
          >
            Contributeurs
          </th>
        </tr>
      </thead>
      <tbody>
        <tr
          v-for="project in filteredProjects"
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
          <td class="py-4 px-6">
            <p
              class="text-left"
              :title="getLastModification(project)"
            >
              {{ new Date(project.info_gitlab.last_activity_at).toLocaleString() }}
            </p>
            <p class="italic">
              {{ getLastModification(project) }}
            </p>
          </td>
          <td class="py-4 px-6">
            {{ getFileCount(project) }}
          </td>
          <td class="py-4 px-6">
            {{ getProjectCommitCount(project) }}
          </td>
          <td class="py-4 px-6">
            {{ project.branches.length }}
          </td>
          <td class="py-4 px-6">
            <i
              class="fa-solid fa-people-group cursor-pointer"
              @click="openContributorsModal(project)"
            />
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
export default {
    name: 'DashboardComponent',
    props: {
        projects: {
            type: Array,
            required: true
        }
    },
    data() {
        return {
            filtre_search: '',
            filtre_fichiers: null,
            filtre_commits: null
        };
    },
    computed: {
        filteredProjects() {
            let localProjects = this.projects;
            if (this.filtre_search !== '')
                localProjects = localProjects.filter(p => p.info_gitlab.name.toLowerCase().includes(this.filtre_search.toLowerCase()));
            if (this.filtre_fichiers !== null && this.filtre_fichiers !== '')
                localProjects = localProjects.filter(p => this.getFileCount(p) === this.filtre_fichiers);
            if (this.filtre_commits !== null && this.filtre_commits !== '')
                localProjects = localProjects.filter(p => this.getProjectCommitCount(p) === this.filtre_commits);
            return localProjects;
        }
    },
    methods: {
        getProjectCommitCount(project) {
            if (project.contributors.length > 0) {
                return project.contributors.map(contributor => contributor.commits).reduce((acc, add) => acc + add, 0);
            }
            return 0;
        },
        getLastModification(project) {
            if (project.commits.length > 0) {
                const lastCommit = project.commits[0];
                return lastCommit.author_name + ' - ' + lastCommit.title;
            } else {
                return 'Création du projet';
            }
        },
        getFileCount(project) {
            return  project.files.filter(function(file){
                return file.type === "blob";
            }).length;
        },
        openContributorsModal(project) {
            let content = '<ul>';
            if (project.contributors.length > 0) {
                project.contributors.forEach(function (contributor) {
                    content += `<li>${contributor.name} - ${contributor.commits} commits`;
                });
            } else {
                content += 'Aucun contributeur pour ce projet.';
            }

            content += '</ul>';

            this.$vfm.show({
                component: 'InfoModal',
                on: {
                    close(close) {
                        close();
                    }
                },
                slots: {
                    title: "Liste des contributeurs du projet",
                    desc: content
                }
            });
        },
        reset () {
            this.filtre_search = '';
            this.filtre_fichiers = null;
            this.filtre_commits = null;
        }
    }
};
</script>
