<template>
  <div class="container max-w-3xl mx-auto py-8">
    <h2 class="text-2xl font-bold text-gray-900 sm:text-3xl mb-4 text-center">
      {{ type == 'edition' ? 'Édition d\'un groupe' : 'Création d\'un groupe' }}
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
                for="group-name"
                class="block text-gray-700 text-sm font-medium mb-2 required_field"
              >Nom</label>
              <input
                id="group-name"
                v-model="form.name"
                type="text"
                name="group-name"
                placeholder="Fise"
                class="border border-gray-400 rounded w-full py-2 px-3 text-gray-700 text-sm leading-tight focus:outline-none focus:border-purple-300"
              >
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
import { useRoute } from 'vue-router';

export default {
    name: 'UserForm',
    components: {
    },
    data () {
        return {
            type: 'creation',
            id_group: null, // L'id de l'utilisateur si on est en édition
            form: {} // Le formulaire de la page
        };
    },
    created () {
        this.$store.dispatch('user/setLoading', true);

        // Récupération de l'id dans le cas où on est en édition
        const route = useRoute();
        if (route.params.id) {
            this.type = 'edition';
            this.id_group = route.params.id;
        }

        // Init du formulaire
        this.initForm();

        const promises = [];

        // Chargement de l'utilisateur si nous sommes en édition
        if (this.type === 'edition') {
            promises.push(APIService.get('admin/group/' + this.id_group).then(result => {
                this.form.name = result.data.label_group;
            }));
        }

        Promise.all(promises).then(() => {
            this.$store.dispatch('user/setLoading', false);
        });
    },
    methods: {
        initForm() {
            this.form = {
                name: ''
            };
        },

        validateForm () {
            if (this.form.name.trim().length < 1)
                return "Veuillez remplir tous les champs obligatoires.";

            return 'ok';
        },

        onSubmit() {
            const validation = this.validateForm();
            if (validation !== "ok")
                return this.$toast.error(validation);

            this.$store.dispatch('user/setLoading', true);
            
            const payload = {
                name: this.form.name
            };

            if (this.type === 'creation') {
                APIService.post('admin/group/create', payload).then(result => {
                    if (result.message === "INSERT_OK"){
                        this.$router.push({ name: 'AdminView' });
                        this.initForm();
                        this.$toast.success("Le groupe a bien été créé.");
                        this.$store.dispatch('user/setLoading', false);
                    } else {
                        this.$toast.error("Une erreur est survenue lors de la création du groupe.");
                        this.$store.dispatch('user/setLoading', false);
                    }
                });
            }
            
            if (this.type === 'edition') {
                APIService.post('admin/group/' + this.id_group + '/edit', payload).then(result => {
                    if (result.message === "EDIT_OK"){
                        this.$router.push({ name: 'AdminView' });
                        this.initForm();
                        this.$toast.success("Le groupe a bien été modifié.");
                        this.$store.dispatch('user/setLoading', false);
                    } else {
                        this.$toast.error("Une erreur est survenue lors de la modification du groupe.");
                        this.$store.dispatch('user/setLoading', false);
                    }
                });
            }
        }
    }
};

</script>

<style src="@vueform/multiselect/themes/default.css"></style>
