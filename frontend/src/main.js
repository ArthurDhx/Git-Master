import { createApp } from 'vue';
import App from './App.vue';
import router from './router';
import store from './store';
import InterceptorRequests from './services/InterceptorRequests';
import axios from 'axios';
import VueAxios from 'vue-axios';
import Toaster from "@meforma/vue-toaster";
import VCalendar from 'v-calendar';
import vfmPlugin from 'vue-final-modal';
import VueAwesomePaginate from "vue-awesome-paginate";
import InfoModal from "./components/InfoModal";
import InputModal from "./components/InputModal";
import ClassicModal from "./components/ClassicModal";
import DeleteModal from "./components/DeleteModal";
import TabModal from "./components/TabModal";

// CSS
import './assets/tailwind.css';
import('@/assets/style.css');
import 'v-calendar/dist/style.css';
import "vue-awesome-paginate/dist/style.css";

InterceptorRequests(store);

// Config TOAST
const toastOptions = {
    position: "bottom-right"
};

createApp(App)
    .use(Toaster, toastOptions)
    .use(store)
    .use(router)
    .use(VueAxios, axios)
    .use(VCalendar, {})
    .use(vfmPlugin)
    .use(VueAwesomePaginate)
    .component("InfoModal", InfoModal)
    .component("InputModal", InputModal)
    .component("ClassicModal", ClassicModal)
    .component("DeleteModal", DeleteModal)
    .component("TabModal", TabModal)
    .mount('#app');
