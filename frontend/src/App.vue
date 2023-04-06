<template>
  <div v-if="getState">
    <router-view />
  </div>
  <div v-else>
    Loading...
  </div>
</template>

<script>
export default {
    name: 'App',
    computed: {
        getState () {
            return this.$store.getters['user/getUserStateLoaded'];
        }
    }
};
</script>
