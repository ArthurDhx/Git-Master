<template>
  <div class="bg-gray-800">
    <div class="max-w-7xl mx-auto px-2 md:px-6 lg:px-8">
      <div class="flex items-center justify-between h-16">
        <div
          class="flex-1 flex items-center justify-center md:items-stretch md:justify-start"
        >
          <div class="flex space-x-4 items-center justify-center text-center">
            <div class="flex space-x-4">
              <router-link
                :to="{name: 'RepositoriesList'}"
                class="px-3 py-2 rounded-md font-medium text-gray-300 hover:bg-gray-700 hover:text-white"
              >
                Groupes GITLAB
              </router-link>
              <router-link
                :to="{name: 'StudentsList'}"
                class="px-3 py-2 rounded-md font-medium text-gray-300 hover:bg-gray-700 hover:text-white"
              >
                Étudiants
              </router-link>
              <router-link
                :to="{ name: 'PupilGroups' }"
                class="px-3 py-2 rounded-md font-medium text-gray-300 hover:bg-gray-700 hover:text-white"
              >
                Groupes d'élèves
              </router-link>
              <router-link
                v-if="isUserAdmin"
                :to="{ name: 'AdminView' }"
                class="px-3 py-2 rounded-md font-medium text-gray-300 hover:bg-gray-700 hover:text-white"
              >
                Admin
              </router-link>
            </div>
          </div>
        </div>
        <router-link 
          v-if="isUserConnected"
          :to="{path: '/user/' + $store.getters['user/getUserInfos'].id_user + '/edit'}"
          class="flex px-3 rounded-md font-medium text-gray-300 hover:bg-gray-700 hover:text-white"
        >
          <div
            class="hidden md:block absolute inset-y-0flex items-center pr-2 md:static md:inset-auto md:ml-2 md:pr-0"
          >
            <p class="py-3 rounded-md font-medium text-gray-300 hover:bg-gray-700 hover:text-white">
              {{ $store.getters["user/getUserInfos"].lastname }}
            </p>
          </div>
          <div class="inset-y-0 flex items-center pr-2 md:static md:inset-auto md:ml-4 md:pr-0">
            <svg
              v-if="!isUserPicture"
              class="text-gray-300"
              fill="currentColor"
              width="24"
              height="24"
            >
              <path d="M24 20.993V24H0v-2.996A14.977 14.977 0 0112.004 15c4.904 0 9.26 2.354 11.996 5.993zM16.002 8.999a4 4 0 11-8 0 4 4 0 018 0z" />
            </svg>
            <img
              v-if="isUserPicture"
              :src="$store.getters['user/getUserInfos'].picture"
              class="text-gray-300 w-8 h-8 rounded-full"
            >
          </div>
        </router-link>
        <div
          class="hidden md:block absolute inset-y-0 right-0 flex items-center pr-2 md:static md:inset-auto md:ml-6 md:pr-0"
        >
          <button
            class="px-4 py-2 rounded-md font-medium text-white bg-red-500 hover:bg-red-600"
            type="submit"
            @click="logout"
          >
            <span>Déconnexion</span>
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
    name: "NavComponent",
    computed: {
        isUserAdmin() {
            return this.$store.getters["user/isUserAdmin"];
        },
        isUserPicture() {
            return this.$store.getters["user/getUserInfos"].picture;
        },
        isUserConnected() {
            return this.$store.getters["user/getUserInfos"];
        }
    },
    methods: {
        logout() {
            this.$store.dispatch("user/logout");
        }
    }
};
</script>
