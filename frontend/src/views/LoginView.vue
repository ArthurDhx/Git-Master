<template>
  <div class="mx-auto w-full mt-8">
    <div class="w-full max-w-md mr-auto ml-auto">
      <div class="mb-3 text-center">
        <h1 class="text-gray-700 text-3xl font-bold">
          Connexion à votre compte
        </h1>
      </div>
      <div class="bg-white shadow  rounded-md px-8 py-8">
        <form
          ref="form"
          @submit.prevent="login"
        >
          <div class="mb-4">
            <label
              class="block text-gray-700 text-sm font-medium mb-2"
              for="email"
            > Email </label>
            <input
              id="email"
              v-model="formLogin.email"
              class="border border-gray-400 rounded w-full py-2 px-3 text-gray-700 text-sm leading-tight focus:outline-none focus:border-purple-300"
              type="email"
              placeholder="john.smith@exemple.fr"
            >
          </div>
          <div class="mb-4">
            <label
              class="block text-gray-700 text-sm font-medium mb-2"
              for="password"
            > Mot de passe </label>
            <input
              id="password"
              v-model="formLogin.password"
              class="border border-gray-400 rounded w-full py-2 px-3 text-gray-600 text-sm leading-tight focus:outline-none focus:border-purple-300"
              type="password"
              placeholder="***************"
            >
          </div>
          <button
            type="submit"
            class="bg-purple-500 border-purple-500 hover:bg-purple-600 text-white font-semibold text-sm py-3 px-0 rounded text-center w-full"
          >
            Connexion
          </button>
        </form>
      </div>
    </div>
  </div>
</template>


<script>
export default {
    name: 'Login',
    data () {
        return {
            formLogin: {
                email: '',
                password: ''
            }
        };
    },
    methods: {
        validateForm () {
            if (this.formLogin.email.trim().length < 1 || this.formLogin.password.trim().length < 1)
                return "Veuillez remplir tous les champs.";

            return 'ok';
        },

        login () {
            const validation = this.validateForm();
            if (validation !== "ok")
                return this.$toast.error(validation);

            this.$store.dispatch('user/login', this.formLogin).then((response) => {
                switch (response) {
                case 'LOGIN_BAD_PASSWORD':
                    return this.$toast.error("Mot de passe invalide.");
                case 'LOGIN_USER_NOT_EXIST':
                    return this.$toast.error("Ce compte n'existe pas.");
                }
            });
        }
    }
};
</script>
