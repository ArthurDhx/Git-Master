<template>
  <div class="container mx-auto py-8">
    <h2 class="text-2xl font-bold text-gray-900 sm:text-3xl mb-4 text-center flex justify-center items-center gap-4">
      Groupes GITLAB
      <div class="text-right mb-1">
        <button
          class="rounded-md px-2 py-1 text-sm border border-gray-300 bg-white hover:bg-gray-200 text-gray-600"
          @click="addGroup()"
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
            class="px-4 py-2 border border-gray-300 bg-white hover:bg-gray-200 text-gray-600 text-sm font-medium rounded-md"
            @click="reset()"
          >
            Réinitialiser les filtres
          </button>
        </div>

        <div class="grid grid-cols-2 md:grid-cols-3 xl:grid-cols-4 gap-8 mt-2 border-t border-gray-300 py-3">
          <div>
            <span class="text-gray-700 block text-sm font-medium mb-2">Filtrage par nom</span>
            <input
              v-model="searchFilter"
              type="text"
              placeholder="Rechercher par nom.."
              class="bg-white border rounded w-full py-2 px-3 text-gray-700 text-sm focus:outline-none focus:border-purple-300"
            >
          </div>

          <div>
            <span class="text-gray-700 block text-sm font-medium mb-2">Filtrage par enseignant</span>
            <Multiselect
              v-model="teacherFilter"
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
            <span class="text-gray-700 block text-sm font-medium mb-2">Filtrage par état</span>
            <select
              v-model="statutFilter"
              class="border border-gray-200 rounded w-full py-2 px-3 text-gray-700 text-sm focus:outline-none focus:border-purple-300"
            >
              <option value="all">
                /
              </option>
              <option value="false">
                Non actif
              </option>
              <option value="true">
                Actif
              </option>
            </select>
          </div>

          <div>
            <span class="text-gray-700 block text-sm font-medium mb-2">Filtrage par lien</span>
            <select
              v-model="membershipFilter"
              class="border border-gray-200 rounded w-full py-2 px-3 text-gray-700 text-sm focus:outline-none focus:border-purple-300"
            >
              <option value="all">
                /
              </option>
              <option value="member">
                Créateur ou enseignant
              </option>
              <option value="creator">
                Créateur
              </option>
              <option value="teacher">
                Enseignant
              </option>
            </select>
          </div>

          <div>
            <span class="text-gray-700 block text-sm font-medium mb-2 ">Filtrage par date courante</span>
            <select
              v-model="currentDateFilter"
              class="border border-gray-200 rounded w-full py-2 px-3 text-gray-700 text-sm focus:outline-none focus:border-purple-300"
            >
              <option value="all">
                /
              </option>
              <option value="Current_Date">
                Evènements (O/F) à venir
              </option>
              <option value="PRE_Current_Date">
                Evènements (O/F) passés
              </option>
            </select>
          </div>
        </div>
      </div>
    </div>

    <div class="container mx-auto mt-4">
      <div class="w-full flex flex-wrap">
        <div class="w-full lg:pr-5 lg:w-4/6">
          <div class="text-center section">
            <v-calendar
              class="custom-calendar max-w-full"
              :masks="masks"
              :attributes="attributes"
              disable-page-swipe
              is-expanded
            >
              <template #day-content="{ day, attributes }">
                <div class="flex flex-col h-full z-10 overflow-hidden">
                  <span class="day-label text-sm text-gray-900">{{ day.day }}</span>
                  <div class="flex-grow overflow-y-auto overflow-x-auto">
                    <p
                      v-for="attribut in attributes"
                      :id="attribut.id"
                      :key="attribut.id"
                      class="text-xs leading-tight rounded-sm p-1 mt-0 mb-1 hover:cursor-pointer"
                      :class="attribut.customData.class"
                      @click="editGroup(attribut.customData.id)"
                    >
                      <span v-html="attribut.customData.title" />
                    </p>
                  </div>
                </div>
              </template>
            </v-calendar>
          </div>
        </div>
        <div class="w-full lg:pl-5 lg:w-2/6 lg:border-l lg:border-gray-300">
          <div
            v-for="group in filteredGroups"
            :key="group.id_repo"
            class="p-2 mt-4 mb-4 bg-white border hover:opacity-75 shadow hover:cursor-pointer"
            @click="editGroup(group.id_repo)"
          >
            <span class="font-semibold block">{{ group.label_group }}</span>
            <span class="font-light text-sm text-gray-500 block">Créateur : {{ group.creator.firstname }} {{ group.creator.lastname }}</span>
            <span class="font-light text-sm text-gray-500">Enseignant(s) : </span>
            <span
              v-for="user, index in group.users"
              :key="index"
              class="font-light text-sm text-gray-500"
            >
              <span v-if="(user.id_user !== group.creator.id_user)">{{ user.firstname }} {{ user.lastname }}
                <span v-if="index < group.users.length - 1 && group.users[index+1].id_user != group.creator.id_user">, </span>
              </span>
            </span>
            <div class="text-right">
              <span
                v-if="group.actif"
                class="rounded-md px-1 text-sm text-white bg-green-500"
              >Actif</span>
              <span
                v-else
                class="rounded-md px-1 text-sm text-white bg-red-500"
              >Inactif</span>
            </div>
          </div>
          <Pagination :data="pagination" />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import APIService from '../services/APIService';
import Multiselect from '@vueform/multiselect';
import Pagination from '../components/Pagination';

export default {
    name: 'RepositoriesList',
    components: {
        Multiselect,
        Pagination
    },
    data () {
        return {
            groupsList: [],
            teachersList: [],
            searchFilter: '',
            teacherFilter: [],
            statutFilter: 'all',
            membershipFilter: 'member',
            currentDateFilter: "all",
            masks: {
                weekdays: 'WWW'
            },
            attributes: [],
            pagination: {
                totalItems: 0,
                itemsPerPage: 6,
                maxPagesShown: 2,
                currentPage: 1
            }
        };
    },
    computed: {
        filteredGroups() {
            const current_user = this.$store.getters['user/getUserInfos'];

            if (current_user) {
                const repo_groups = this.groupsList
                    .filter(el => el.label_group.toLowerCase().includes(this.searchFilter.toLowerCase()))
                    .filter(el => (this.teacherFilter.length === 0 || this.teacherFilter.some((teacher) => el.users.some((user) => user.id_user === teacher.value))))
                    .filter(el => (this.statutFilter === 'all' || (el.actif.toString()) === this.statutFilter))
                    .filter(el => (this.membershipFilter === 'all')
                                              || ((this.membershipFilter === 'creator') && el.creator.id_user === current_user.id_user)
                                              || ((this.membershipFilter === 'teacher') && el.creator.id_user !== current_user.id_user && el.users.some((user) => user.id_user === current_user.id_user))
                                              || ((this.membershipFilter === 'member') &&  el.users.some((user) => user.id_user === current_user.id_user)))
                    .filter(el => (this.currentDateFilter === 'all') 
                                              || ((this.currentDateFilter === 'Current_Date') && ((el.end_date && new Date(el.end_date).getTime() >= new Date().getTime()) || new Date(el.start_date).getTime() >= new Date().getTime()))
                                              || ((this.currentDateFilter === 'PRE_Current_Date') && ((el.end_date && new Date(el.end_date).getTime() < new Date().getTime()) || new Date(el.start_date).getTime() < new Date().getTime())));
                const first_element = (this.pagination.currentPage - 1) * this.pagination.itemsPerPage;
                const last_element = first_element + this.pagination.itemsPerPage;
                this.refreshCalendar(repo_groups);
                this.setPaginationTotalItems(repo_groups.length);
                return repo_groups.slice(first_element, last_element);
            }
            
            return this.groupsList;
        }
    },
    created () {
        this.$store.dispatch('user/setLoading', true);
        const promises = [];
        promises.push(this.loadGroups());
        promises.push(APIService.get('repository/teacher/all').then(result => {
            this.teachersList = result.data.map((row) => {return {value: row.id_user, label: row.lastname.toUpperCase() + " " + row.firstname};});
        }));
        Promise.all(promises).then(() => {
            this.$store.dispatch('user/setLoading', false);
        });
    },
    methods: {
        loadGroups(path='repository/') {
            return APIService.get(path).then(result => {
                this.$store.dispatch('user/setLoading', false);
                this.groupsList = result.data.map((group) => (
                    {
                        ...group, 
                        actif: group.is_open,
                        inactif: !group.is_open
                    }));
                this.groupsList.sort((a, b) => {
                    if (a.start_date === b.start_date) {
                        return a.label_group.localeCompare(b.label_group);
                    }
                    return new Date(a.start_date) > new Date(b.start_date);
                });         
                this.refreshCalendar();
            });
        },
        refreshCalendar(repo_groups = this.groupsList) {
            let compteur=0;
            this.attributes = [];
            repo_groups.forEach(element => {
                if (!(this.currentDateFilter === 'Current_Date' && new Date(element.start_date).getTime() <= new Date().getTime())){
                    this.attributes.push({
                        key: compteur,
                        customData: {
                            title: `<strong><u> Date d'ouverture du repo :</u></strong> ${new Date(element.start_date).getHours()<10?'0':''}${new Date(element.start_date).getHours()}h${new Date(element.start_date).getMinutes()<10?'0':''}${new Date(element.start_date).getMinutes()}
                        <br><strong><u> Nom du repo :</u></strong> ${element.label_group}`,
                            class: 'bg-green-500 text-white text-align:justify text-justify: auto',
                            id: element.id_repo
                        },
                        dates: new Date(element.start_date)
                    }); 
                }
                compteur++;
                if (element.end_date !== null && !(this.currentDateFilter === 'PRE_Current_Date' && new Date(element.end_date).getTime() >= new Date().getTime())) {
                    this.attributes.push({
                        key: compteur,
                        customData: {
                            title: `<strong><u> Date de fermeture du repo :</u></strong> ${new Date(element.end_date).getHours()<10?'0':''}${new Date(element.end_date).getHours()}h${new Date(element.end_date).getMinutes()<10?'0':''}${new Date(element.end_date).getMinutes()}
                            <br><strong><u> Nom du repo :</u></strong> ${element.label_group}`,
                            class: 'bg-red-500 text-white text-align:justify text-justify: auto',
                            id: element.id_repo
                        },
                        dates: new Date(element.end_date)
                    });
                    compteur++;
                }  
            });
        },
        addGroup() {
            this.$router.push({ name: 'RepoGroupCreation' });
        },
        reset () {
            this.searchFilter = '',
            this.teacherFilter = [],
            this.statutFilter = 'all',
            this.membershipFilter = 'member';
            this.currentDateFilter = "all";
        },
        editGroup(_id) {
            this.$router.push({ name: 'RepositoryProfil', params: { id: _id } });
        },
        setPaginationTotalItems(nb) {
            this.pagination.totalItems = nb;
        }      
    }
};
</script>

<style src="@vueform/multiselect/themes/default.css"></style>
<style lang="postcss" scoped>
::-webkit-scrollbar {
  width: 0px;
}
::-webkit-scrollbar-track {
  display: none;
}
/deep/ .custom-calendar.vc-container {
  --day-border: 1px solid #b8c2cc;
  --day-border-highlight: 1px solid #b8c2cc;
  --day-width: 90px;
  --day-height: 120px;
  --weekday-bg: #f8fafc;
  --weekday-border: 1px solid #eaeaea;
  border-radius: 0;
  width: 100%;
  & .vc-header {
    background-color: #f1f5f8;
    padding: 10px 0;
  }
  & .vc-weeks {
    padding: 0;
  }
  & .vc-weekday {
    background-color: var(--weekday-bg);
    border-bottom: var(--weekday-border);
    border-top: var(--weekday-border);
    padding: 5px 0;
  }
  & .vc-day {
    padding: 0 5px 3px 5px;
    text-align: left;
    min-height: var(--day-height);
    min-width: var(--day-width);
    background-color: white;
    &.weekday-1,
    &.weekday-7 {
      background-color: #eff8ff;
    }
    &:not(.on-bottom) {
      border-bottom: var(--day-border);
      &.weekday-1 {
        border-bottom: var(--day-border-highlight);
      }
    }
    &:not(.on-right) {
      border-right: var(--day-border);
    }
  }
  & .vc-day-dots {
    margin-bottom: 5px;
  }
}
</style>
