<template>
  <div class="container max-w-3xl mx-auto py-8">
    <h2 class="text-2xl font-bold text-gray-900 sm:text-3xl mb-4 text-center">
      {{ type == 'edition' ? 'Édition d\'un utilisateur' : 'Création d\'un utilisateur' }}
    </h2>

    <div class="w-full shadow p-5 sm:rounded-lg bg-white">
      <div class="relative">
        <form
          ref="form"
          @submit.prevent="onSubmit"
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
                :disabled="getUserToken() === null || getUserToken() === ''"
                class="border border-gray-400 rounded w-full py-2 px-3 text-gray-700 text-sm leading-tight focus:outline-none focus:border-purple-300"
              >
            </div>

            <div
              v-if="type != 'edition'"
              class="col-span-4 sm:col-span-2 lg:col-span-2"
            >
              <label
                for="password"
                class="block text-gray-700 text-sm font-medium mb-2 required_field"
              >Mot de passe</label>
              <input
                id="password"
                v-model="form.password"
                type="password"
                name="password"
                placeholder="***************"
                class="border border-gray-400 rounded w-full py-2 px-3 text-gray-700 text-sm leading-tight focus:outline-none focus:border-purple-300"
              >
            </div>

            <div
              v-else
              class="col-span-4 sm:col-span-2 lg:col-span-2"
            >
              <label
                for="password"
                class="block text-gray-700 text-sm font-medium mb-2"
              >Nouveau mot de passe</label>
              <input
                id="password"
                v-model="form.password"
                type="password"
                name="password"
                placeholder="***************"
                class="border border-gray-400 rounded w-full py-2 px-3 text-gray-700 text-sm leading-tight focus:outline-none focus:border-purple-300"
              >
            </div>

            <div class="col-span-4 sm:col-span-2">
              <label
                for="token_gitlab"
                class="block text-gray-700 text-sm font-medium mb-2 required_field"
              >Token GitLab</label>
              <input
                id="token_gitlab"
                v-model="form.token_gitlab"
                type="text"
                name="token_gitlab"
                class="border border-gray-400 rounded w-full py-2 px-3 text-gray-700 text-sm leading-tight focus:outline-none focus:border-purple-300"
              >
            </div>
            
            <div 
              v-if="isUserAdmin"
              class="col-span-4 sm:col-span-2"
            >
              <label
                for="token_gitlab"
                class="block text-gray-700 text-sm font-medium mb-2 required_field"
              >Rôles</label>
              <Multiselect
                v-model="selectedRoles"
                :options="rolesList"
                object
                mode="tags"
                placeholder="Choisir des rôles"
                :close-on-select="false"
                class="multiselect border border-gray-400 text-gray-700 text-sm focus:outline-none focus:border-purple-300"
              />
            </div>

            <div class="col-span-4 sm:col-span-2">
              <label class="block text-sm font-medium text-gray-700">Photo</label>
              <div class="mt-1 flex items-center">
                <span class="inline-block h-20 w-20 overflow-hidden rounded-full bg-gray-100">
                  <svg
                    v-if="(pictureFile == null || picture == '') && (form.picture == null || form.picture == '')"
                    class="h-full w-full text-gray-300"
                    fill="currentColor"
                    viewBox="0 0 24 24"
                  >
                    <path d="M24 20.993V24H0v-2.996A14.977 14.977 0 0112.004 15c4.904 0 9.26 2.354 11.996 5.993zM16.002 8.999a4 4 0 11-8 0 4 4 0 018 0z" />
                  </svg>

                  <div v-if="uploadStatus == false && pictureFile != null">
                    <img
                      class="h-full w-full"
                      src="../assets/spinner.svg"
                    >
                  </div>

                  <img
                    v-if="form.picture != null"
                    :src="form.picture"
                    class="h-full"
                    style="max-width: none!important;"
                  >
                </span>
                <div class="mt-1 ml-3 flex justify-center rounded-md border-2 border-gray-300 px-2 pt-2 pb-2">
                  <label
                    for="file-upload"
                    class="relative cursor-pointer rounded-md bg-white font-medium text-purple-600 focus-within:outline-none focus-within:ring-2 focus-within:ring-purple-500 focus-within:ring-offset-2 hover:text-purple-500"
                  >
                    <span>Définir une photo de profil</span>
                    <input
                      id="file-upload"
                      name="file-upload"
                      type="file"
                      class="sr-only"
                      @change="getPicture"
                    >
                  </label>
                </div>
              </div>
            </div>
          </div>

          <div class="text-right">
            <button
              type="button"
              class="px-4 py-2 border border-gray-300 bg-white hover:bg-gray-200 text-gray-600 font-medium rounded-md mr-2"
              @click="$router.push({ name: 'AdminView' })"
            >
              Retour
            </button>
            <button
              type="submit"
              class="px-4 py-2 rounded-md font-medium text-white bg-purple-500 hover:bg-purple-600"
            >
              {{ type == 'edition' ? 'Sauvegarder' : 'Créer' }}
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
import ImgService from '../services/ImgService';
import Multiselect from '@vueform/multiselect';
import { useRoute } from 'vue-router';

export default {
    name: 'UserForm',
    components: {
        Multiselect
    },
    data () {
        return {
            type: 'creation',
            id_user: null, // L'id de l'utilisateur si on est en édition
            form: {}, // Le formulaire de la page
            pictureFile: null, // Le fichier que l'utilisateur veut upload
            uploadStatus: true, // Status de l'upload
            rolesList: [], // Liste des rôles de l'app
            users: [],
            selectedRoles: [] // Liste des rôles select
        };
    },
    computed: {
        isUserAdmin() {
            return this.$store.getters["user/isUserAdmin"];
        }
    },
    created () {
        this.$store.dispatch('user/setLoading', true);

        // Récupération de l'id dans le cas où on est en édition
        const route = useRoute();
        if (route.params.id) {
            this.type = 'edition';
            this.id_user = route.params.id;
        }

        // Init du formulaire
        this.initForm();

        const promises = [];

        // Chargement des rôles
        promises.push(APIService.get('roles').then(result => {
            this.rolesList = result.data.map((row) => { return { value: row.id_role, label: row.display_role, users: row.users }; });
        }));

        // Chargement de l'utilisateur si nous sommes en édition
        if (this.type === 'edition') {
            promises.push(APIService.get('user/' + this.id_user).then(result => {
                this.form = result.data;
                this.selectedRoles = result.data.roles.map((row) => { return { value: row.id_role, label: row.display_role }; });
            }));
        }

        Promise.all(promises).then(() => {
            this.$store.dispatch('user/setLoading', false);
        });
    },
    methods: {
        initForm() {
            this.form = {
                firstname: '',
                lastname: '',
                uid_ul: '',
                email: '',
                password: '',
                token_gitlab: '',
                picture: null
            };

            this.pictureFile = null;
            this.selectedRoles = [];
            this.gitlab_id = 0;
        },

        getPicture () {
            this.pictureFile = event.target.files[0];
            this.uploadStatus = false;

            ImgService.uploadImage(this.pictureFile).then(res => {
                if (res !== 'error') {
                    this.form.picture = res;
                    this.uploadStatus = true;
                } else {
                    this.form.picture = null;
                    this.uploadStatus = true;
                }
            });
        },

        validateForm () {
            if (this.form.firstname.trim().length < 1 || this.form.lastname.trim().length < 1 || this.form.uid_ul.trim().length < 1 
                 || this.form.email.trim().length < 1 || this.form.token_gitlab.trim().length < 1)
                return "Veuillez remplir tous les champs obligatoires.";

            if (this.selectedRoles.length === 0)
                return "Veuillez choisir au moins un rôle.";

            if (this.type === 'creation' && (this.form.password.trim().length < 5))
                return "Le mot de passe doit faire au moins 5 caractères.";

            return 'ok';
        },

        getUserToken() {
            if (this.$store.getters['user/getUserInfos'] !== null) {
                const token = this.$store.getters['user/getUserInfos'].token_gitlab;
                return token ? token : '';
            }

            return null;
        },

        onSubmit() {
            const validation = this.validateForm();
            if (validation !== "ok")
                return this.$toast.error(validation);

            this.$store.dispatch('user/setLoading', true);

            if (this.getUserToken() !== null && this.getUserToken() !== '') {
                GitLabService.getUser(this.form.email).then(result => {
                    if (!result || result.length === 0) {
                        this.$store.dispatch('user/setLoading', false);
                        return this.$toast.error("L'utilisateur Gitlab n'existe pas (adresse mail incorrect).");
                    } else {
                        this.gitlab_id = result[0].id;
                    }

                    if (!this.uploadStatus) {
                        this.$toast.error("La photo est en cours de téléchargement...");
                        this.$store.dispatch('user/setLoading', false);
                    } else {
                        const payload = {
                            firstname: this.form.firstname,
                            lastname: this.form.lastname,
                            uid_ul: this.form.uid_ul,
                            email: this.form.email,
                            picture: this.form.picture,
                            id_gitlab: this.gitlab_id,
                            token_gitlab: this.form.token_gitlab,
                            roles: this.selectedRoles.map(item => { return item["value"]; })
                        };

                        // Si nous sommes en création
                        if (this.type === 'creation') {
                            payload.password = this.form.password;

                            APIService.post('admin/user/create', payload).then(result => {
                                if (result.message === "INSERT_OK") {
                                    this.initForm();
                                    this.$toast.success("L'utilisateur a été ajouté.");
                                    this.$store.dispatch('user/setLoading', false);
                                } else if (result.message === "EMAIL_ALREADY_USED") {
                                    this.$toast.error("L'email est déjà utilisé.");
                                    this.$store.dispatch('user/setLoading', false);
                                }
                            });
                        }

                        // Si nous sommes en édition
                        if (this.type === 'edition') {
                            if (this.form.password && this.form.password.trim().length > 0)
                                payload.password = this.form.password;
                            
                            APIService.post('admin/user/' + this.id_user + '/edit', payload).then(result => {
                                if (result.message === "EDIT_OK") {
                                    if (this.id_user === this.$store.getters['user/getUserInfos'].id_user) {
                                        this.$store.dispatch('user/updateUserData').then(() => {});
                                    }

                                    this.$toast.success('L\'utilisateur a bien été modifié.');
                                    this.$router.push({ name: 'AdminView' });
                                    this.$store.dispatch('user/setLoading', false);
                                } else if (result.message === "EMAIL_ALREADY_USED") {
                                    this.$store.dispatch('user/setLoading', false);
                                    return this.$toast.error("L'email est déjà utilisé.");
                                }
                            });
                        }
                    }
                });
            } else {
                this.$store.dispatch('user/setLoading', false);
                return this.$toast.error("Problème de configuration de votre token gitlab (inexistant).");
            }
        }
    }
};

</script>

<style src="@vueform/multiselect/themes/default.css"></style>
