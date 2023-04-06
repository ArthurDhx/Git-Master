<template>
  <div class="container max-w-3xl mx-auto py-8">
    <h2 
      v-if="selectedTab === 1"
      class="text-2xl font-bold text-gray-900 sm:text-3xl mb-4 text-center flex justify-center items-center gap-4"
    >
      Utilisateurs
      <div class="text-right mb-1">
        <button
          class="rounded-md px-2 py-1 text-sm border border-gray-300 bg-white hover:bg-gray-200 text-gray-600"
          @click="addUser()"
        >
          <i class="fa-solid fa-plus" />
        </button>
      </div>
    </h2>
    <h2 
      v-if="selectedTab === 2"
      class="text-2xl font-bold text-gray-900 sm:text-3xl mb-4 text-center flex justify-center items-center gap-4"
    >
      Groupes
      <div class="text-right mb-1">
        <button
          class="rounded-md px-2 py-1 text-sm border border-gray-300 bg-white hover:bg-gray-200 text-gray-600"
          @click="addGroup()"
        >
          <i class="fa-solid fa-plus" />
        </button>
      </div>
    </h2>
    <h2 
      v-if="selectedTab === 3"
      class="text-2xl font-bold text-gray-900 sm:text-3xl mb-4 text-center flex justify-center items-center gap-4"
    >
      Années
      <div class="text-right mb-1">
        <button
          class="rounded-md px-2 py-1 text-sm border border-gray-300 bg-white hover:bg-gray-200 text-gray-600"
          @click="addYear()"
        >
          <i class="fa-solid fa-plus" />
        </button>
      </div>
    </h2>
    <h2 
      v-if="selectedTab === 4"
      class="text-2xl font-bold text-gray-900 sm:text-3xl mb-4 text-center flex justify-center items-center gap-4"
    >
      Rôles
      <div class="text-right mb-1">
        <button
          class="rounded-md px-2 py-1 text-sm border border-gray-300 bg-white hover:bg-gray-200 text-gray-600"
          @click="addRole()"
        >
          <i class="fa-solid fa-plus" />
        </button>
      </div>
    </h2>
    <div>
      <div class="mt-6">
        <ul class="hidden text-sm font-medium text-center mb-5 text-gray-500 rounded-lg divide-x divide-gray-200 shadow sm:flex">
          <li class="w-full">
            <a
              href="#"
              :class="{ 'bg-gray-100': selectedTab === 1 }"
              class="inline-block p-4 w-full bg-white hover:text-gray-700 hover:bg-gray-50 rounded-l-lg focus:outline-none"
              @click="selectedTab = 1"
            >Liste des utilisateurs</a>
          </li>
          <li class="w-full">
            <a
              href="#"
              :class="{ 'bg-gray-100': selectedTab === 2 }"
              class="inline-block p-4 w-full bg-white hover:text-gray-700 hover:bg-gray-50 focus:outline-none"
              @click="selectedTab = 2"
            >Liste des groupes</a>
          </li>
          <li class="w-full">
            <a
              href="#"
              :class="{ 'bg-gray-100': selectedTab === 3 }"
              class="inline-block p-4 w-full bg-white hover:text-gray-700 hover:bg-gray-50 focus:outline-none"
              @click="selectedTab = 3"
            >Liste des années</a>
          </li>
          <li class="w-full">
            <a
              href="#"
              :class="{ 'bg-gray-100': selectedTab === 4 }"
              class="inline-block p-4 w-full bg-white hover:text-gray-700 hover:bg-gray-50 rounded-r-lg focus:outline-none"
              @click="selectedTab = 4"
            >Liste des rôles</a>
          </li>
        </ul>
      </div>
      <div 
        v-if="selectedTab === 1"
        class="w-full shadow px-5 py-2 bg-gray-100"
      >
        <div class="relative">
          <div class="flex items-center justify-between mb-2">
            <p class="font-medium">
              Filtres
            </p>
          </div>

          <div class="mt-4">
            <input
              v-model="searchUser"
              type="text"
              placeholder="Rechercher par nom.."
              class="bg-white border rounded w-full py-2 px-3 text-gray-700 text-sm focus:outline-none focus:border-purple-300"
            >
          </div>
        </div>
      </div>
    </div>
    <div 
      v-if="selectedTab == 1"
      class="overflow-x-auto relative shadow-md table-content mt-5"
    >
      <table class="w-full text-sm text-left text-gray-500">
        <thead class="text-xs text-gray-700 uppercase bg-gray-50">
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
              Rôles
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
            v-for="user in filteredUsers"
            :key="user"
            class="bg-white border-b"
          >
            <th
              scope="row"
              class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap"
            >
              {{ user.firstname }}
            </th>
            <td class="py-4 px-6">
              {{ user.lastname }}
            </td>
            <td class="py-4 px-6">
              <span 
                v-for="role in user.roles"
                :key="role.id_role"
                class="inline-block bg-gray-200 rounded-full px-3 py-1 text-sm font-semibold text-gray-700 mr-2"
              >
                {{ role.display_role }}
              </span>
            </td>
            <td class="py-4 px-6">
              <i
                class="fa-solid fa-pen-to-square bg-blue-500 hover:bg-blue-600 text-white font-bold py-1 px-2 text-xs rounded hover:cursor-pointer"
                @click="editUser(user.id_user)"
              />
              <i
                class="fa-solid fa-trash bg-red-400 hover:bg-red-500 text-white font-bold py-1 px-2 text-xs rounded hover:cursor-pointer ml-1"
                @click="deleteUser(user.id_user)"
              />
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <div 
      v-if="selectedTab == 2"
      class="w-full shadow px-5 py-2 bg-gray-100"
    >
      <div class="relative">
        <div class="flex items-center justify-between mb-2">
          <p class="font-medium">
            Filtres
          </p>
        </div>

        <div class="mt-4">
          <input
            v-model="searchGroup"
            type="text"
            placeholder="Rechercher par nom.."
            class="bg-white border rounded w-full py-2 px-3 text-gray-700 text-sm focus:outline-none focus:border-purple-300"
          >
        </div>
      </div>
    </div>
    <div 
      v-if="selectedTab == 2"
      class="overflow-x-auto relative shadow-md table-content mt-5"
    >
      <table class="w-full text-sm text-left text-gray-500">
        <thead class="text-xs text-gray-700 uppercase bg-gray-50">
          <tr>
            <th
              scope="col"
              class="py-3 px-6"
            >
              Id
            </th>
            <th
              scope="col"
              class="py-3 px-6 pr-40"
            >
              Nom
            </th>
            <th
              scope="col"
              class="py-3 px-6 inset-x-0"
            >
              Action
            </th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="group in filteredGroups"
            :key="group"
            class="bg-white border-b"
          >
            <th
              scope="row"
              class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap"
            >
              {{ group.value }}
            </th>
            <td class="py-4 px-6">
              {{ group.label }}
            </td>
            <td class="py-4 px-6">
              <i
                class="fa-solid fa-pen-to-square bg-blue-500 hover:bg-blue-600 text-white font-bold py-1 px-2 text-xs rounded hover:cursor-pointer"
                @click="editGroup(group.value)"
              />
              
              <i 
                v-if="group.students == 0"
                class="fa-solid fa-trash bg-red-400 hover:bg-red-500 text-white font-bold py-1 px-2 text-xs rounded hover:cursor-pointer ml-1"
                @click="deleteGroup(group.value)"
              />
              <i 
                v-if="group.students != 0"
                class="fa-solid fa-trash bg-red-400 hover:bg-red-500 text-white font-bold py-1 px-2 text-xs rounded hover:cursor-pointer ml-1"
                @click="deleteGroup(0)"
              />
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <div 
      v-if="selectedTab == 3"
      class="w-full shadow px-5 py-2 bg-gray-100"
    >
      <div class="relative">
        <div class="flex items-center justify-between mb-2">
          <p class="font-medium">
            Filtres
          </p>
        </div>

        <div class="mt-4">
          <input
            v-model="searchYear"
            type="text"
            placeholder="Rechercher par Année.."
            class="bg-white border rounded w-full py-2 px-3 text-gray-700 text-sm focus:outline-none focus:border-purple-300"
          >
        </div>
      </div>
    </div>
    <div 
      v-if="selectedTab == 3"
      class="overflow-x-auto relative shadow-md table-content mt-5"
    >
      <table class="w-full text-sm text-left text-gray-500">
        <thead class="text-xs text-gray-700 uppercase bg-gray-50">
          <tr>
            <th
              scope="col"
              class="py-3 px-6"
            >
              Id
            </th>
            <th
              scope="col"
              class="py-3 px-6 pr-40"
            >
              Année
            </th>
            <th
              scope="col"
              class="py-3 px-6 inset-x-0"
            >
              Action
            </th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="year in filteredYears"
            :key="year"
            class="bg-white border-b"
          >
            <th
              scope="row"
              class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap"
            >
              {{ year.value }}
            </th>
            <td class="py-4 px-6">
              {{ year.label }}
            </td>
            <td class="py-4 px-6">
              <i
                class="fa-solid fa-pen-to-square bg-blue-500 hover:bg-blue-600 text-white font-bold py-1 px-2 text-xs rounded hover:cursor-pointer"
                @click="editYear(year.value)"
              />
              
              <i 
                v-if="year.students == 0"
                class="fa-solid fa-trash bg-red-400 hover:bg-red-500 text-white font-bold py-1 px-2 text-xs rounded hover:cursor-pointer ml-1"
                @click="deleteYear(year.value)"
              />
              <i 
                v-if="year.students != 0"
                class="fa-solid fa-trash bg-red-400 hover:bg-red-500 text-white font-bold py-1 px-2 text-xs rounded hover:cursor-pointer ml-1"
                @click="deleteYear(0)"
              />
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <div 
      v-if="selectedTab === 4"
      class="w-full shadow px-5 py-2 bg-gray-100"
    >
      <div class="relative">
        <div class="flex items-center justify-between mb-2">
          <p class="font-medium">
            Filtres
          </p>
        </div>

        <div class="mt-4">
          <input
            v-model="searchRole"
            type="text"
            placeholder="Rechercher par nom"
            class="bg-white border rounded w-full py-2 px-3 text-gray-700 text-sm focus:outline-none focus:border-purple-300"
          >
        </div>
      </div>
    </div>
    <div 
      v-if="selectedTab == 4"
      class="overflow-x-auto relative shadow-md table-content mt-5"
    >
      <table class="w-full text-sm text-left text-gray-500">
        <thead class="text-xs text-gray-700 uppercase bg-gray-50">
          <tr>
            <th
              scope="col"
              class="py-3 px-6"
            >
              Id
            </th>
            <th
              scope="col"
              class="py-3 px-6 pr-40"
            >
              Nom
            </th>
            <th
              scope="col"
              class="py-3 px-6 inset-x-0"
            >
              Action
            </th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="role in filteredRole"
            :key="role"
            class="bg-white border-b"
          >
            <th
              scope="row"
              class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap"
            >
              {{ role.value }}
            </th>
            <td class="py-4 px-6">
              {{ role.display }}
            </td>
            <td 
              v-if="role.label !== 'teacher' && role.label !== 'administrator'"
              class="py-4 px-6" 
            >
              <i
                class="fa-solid fa-pen-to-square bg-blue-500 hover:bg-blue-600 text-white font-bold py-1 px-2 text-xs rounded hover:cursor-pointer"
                @click="editRole(role.value)"
              />
              <i 
                class="fa-solid fa-trash bg-red-400 hover:bg-red-500 text-white font-bold py-1 px-2 text-xs rounded hover:cursor-pointer ml-1"
                @click="deleteRole(role)"
              />
            </td>
            <td 
              v-else
              class="py-4 px-6" 
            />
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
import APIService from '../services/APIService';

export default {
    name: 'AdminView',
    data () {
        return {
            usersList: [],
            searchUser: '',
            searchGroup: '',
            searchYear: '',
            searchRole: '',
            groupList: [],
            yearsList: [],
            roleList: [],
            selectedTab: 1
        };
    },
    computed: {
        filteredUsers() {
            return this.usersList.filter(el => (el.firstname + ' ' + el.lastname).toLowerCase().includes(this.searchUser.toLowerCase()))
                .sort((a, b) => (a.lastname > b.lastname) ? 1 : ((b.lastname > a.lastname) ? -1 : 0));
        },

        filteredGroups() {
            return this.groupList.filter(el => (el.label).toLowerCase().includes(this.searchGroup.toLowerCase()))
                .sort((a, b) => (a.label > b.label) ? 1 : ((b.label > a.label) ? -1 : 0));
        },

        filteredYears () {
            return this.yearsList.filter(el => (el.label).toLowerCase().includes(this.searchYear.toLowerCase()))
                .sort((a, b) => (a.label > b.label) ? 1 : ((b.label > a.label) ? -1 : 0));
        },
        filteredRole () {
            return this.roleList.filter(el => (el.display).toLowerCase().includes(this.searchRole.toLowerCase()))
                .sort((a, b) => (a.display > b.display) ? 1 : ((b.display > a.display) ? -1 : 0));
        }
    },
    created () {
        this.$store.dispatch('user/setLoading', true);

        this.initTab();
    },
    methods: {
        initTab() {
            APIService.get('user/all').then(result => {
                this.usersList = result.data;
                this.$store.dispatch('user/setLoading', false);
            });

            APIService.get("admin/group/all").then((result) => {
                this.groupList = result.data.map((row) => {
                    return { value: row.id_group, label: row.label_group, students: row.students.length};
                });
            });
            APIService.get("admin/role/all").then((result) => {
                this.roleList = result.data.map((row) => {
                    return { value: row.id_role, label: row.label_role, display: row.display_role, students: row.users.length};
                });
            });
            APIService.get("admin/year/all").then((result) => {
                this.yearsList = result.data.map((row) => {
                    return { value: row.id_year, label: row.label_year, students: row.students.length};
                });
            });
        },
        editUser(user_id) {
            this.$router.push({ name: 'UserEdition', params: { id: user_id } });
        },
        editGroup(group_id) {
            this.$router.push({ name: 'GroupEdition', params: { id: group_id } });
        },
        editYear(year_id) {
            this.$router.push({ name: 'YearEdition', params: { id: year_id } });
        },
        editRole(role_id) {
            this.$router.push({ name: 'RoleEdition', params: { id: role_id } });
        },
        addUser() {
            this.$router.push({ name: 'UserCreation' });
        },
        addGroup() {
            this.$router.push({ name: 'GroupCreation' });
        },
        addYear() {
            this.$router.push({ name: 'YearCreation' });
        },
        addRole() {
            this.$router.push({ name: 'RoleCreation' });
        },
        async deleteUser(id) {
            const parentObject = this;

            this.$vfm.show({
                component: 'DeleteModal',
                on: {
                    confirm(close) {
                        parentObject.$store.dispatch('user/setLoading', true);

                        APIService.delete('admin/user/' + id).then(() => {
                            parentObject.initTab();
                            parentObject.$toast.success("L'utilisateur a été supprimé.");
                        });

                        close();
                    },
                    cancel(close) {
                        close();
                    }
                },
                slots: {
                    title: "Suppression d'un utilisateur",
                    desc: "Souhaitez-vous réellement supprimer cet utilisateur ?"
                }
            });
        },
        async deleteGroup(id) {
            if (id === 0) {
                this.$toast.error("Vous ne pouvez pas supprimer un groupe qui contient des étudiants.");
                return;
            }
            const parentObject = this;

            this.$vfm.show({
                component: 'DeleteModal',
                on: {
                    confirm(close) {
                        parentObject.$store.dispatch('user/setLoading', true);

                        APIService.delete('admin/group/' + id).then(() => {
                            parentObject.$toast.success("Le groupe a été supprimé.");
                            parentObject.initTab();
                        });

                        close();
                    },
                    cancel(close) {
                        close();
                    }
                },
                slots: {
                    title: "Suppression d'un groupe",
                    desc: "Souhaitez-vous réellement supprimer ce groupe ?"
                }
            });
        },
        async deleteYear(id) {
            if (id === 0) {
                this.$toast.error("Vous ne pouvez pas supprimer une année qui contient des étudiants.");
                return;
            }
            const parentObject = this;

            this.$vfm.show({
                component: 'DeleteModal',
                on: {
                    confirm(close) {
                        parentObject.$store.dispatch('user/setLoading', true);

                        APIService.delete('admin/year/' + id).then(() => {
                            parentObject.$toast.success("L'année a été supprimé.");
                            parentObject.initTab();
                        });

                        close();
                    },
                    cancel(close) {
                        close();
                    }
                },
                slots: {
                    title: "Suppression d'une année",
                    desc: "Souhaitez-vous réellement supprimer une année ?"
                }
            });
        },
        async deleteRole(role) {
            const id = role.value;
            
            if (role.students !== 0) {
                this.$toast.error("Vous ne pouvez pas supprimer un rôle qui est affecté à des utilisateurs.");
                return;
            }

            const parentObject = this;

            this.$vfm.show({
                component: 'DeleteModal',
                on: {
                    confirm(close) {
                        parentObject.$store.dispatch('user/setLoading', true);

                        APIService.delete('admin/role/' + id).then(() => {
                            parentObject.initTab();
                            parentObject.$toast.success("Le rôle a été supprimé.");
                        });

                        close();
                    },
                    cancel(close) {
                        close();
                    }
                },
                slots: {
                    title: "Suppression d'un rôle",
                    desc: "Souhaitez-vous réellement supprimer ce rôle ?"
                }
            });
        }
    }
};

</script>
