import { createStore } from 'vuex';
import user from './user';

const store = createStore({
    modules: {
        user // Import du store 'user'
    }
});

export default store;
