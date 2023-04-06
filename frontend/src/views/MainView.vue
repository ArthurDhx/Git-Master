<template>
  <Navbar />
  <modals-container />
  <loading
    v-model:active="isActive"
    :can-cancel="false"
    color="#da16d4"
    height="128"
    width="128"
    :is-full-page="true"
    loader="bars"
  />
  <router-view />
</template>

<script>
import Navbar from '../components/Navbar.vue';
import Loading from 'vue-loading-overlay';
import { ModalsContainer } from 'vue-final-modal';

import 'vue-loading-overlay/dist/css/index.css';

export default {
    name: 'MainView',
    components: {
        Navbar,
        Loading,
        ModalsContainer
    },
    computed: {
        isActive () {
            return this.$store.getters['user/getIsSpinning'];
        }
    }
};
</script>
