import AuthService from '../services/AuthService';
import StorageService from '../services/StorageService';
import router from '@/router';

// Initialisation du state
const state = {
    userStateLoaded: false,
    loggedIn: false,
    userInfos: null,
    isSpinning: false
};

// Getters
const getters = {
    getIsLogged (state) {
        return state.loggedIn;
    },
    getUserStateLoaded (state) {
        return state.userStateLoaded;
    },
    getUserInfos (state) {
        return state.userInfos;
    },
    isUserAdmin (state) {
        if (!state.loggedIn)
            return false;

        return state.userInfos.roles.map(a => a.label_role).includes('administrator');
    },
    getIsSpinning(state) {
        return state.isSpinning;
    }
};

// Actions
const actions = {
    initLogin ({ commit }) {
        const storedToken = StorageService.get('credentials');

        if (storedToken && storedToken !== "") {
            return AuthService.getUserData().then(response => {
                if (response && response.message === null) {
                    commit('login', response.data);
                } else {
                    StorageService.clear();
                }
                commit('changeLoadingStatus', true);
            });
        } else {
            commit('changeLoadingStatus', true);
        }
    },
    updateUserData({ commit }) {
        return AuthService.getUserData().then(response => {
            commit('changeUserData', response.data);
            return response.message;
        });
    },
    login ({ commit }, data) {
        return AuthService.login(data.email, data.password).then(response => {
            if (response.message === null) {
                commit('login', response.data.user_infos);
                router.push({ name: 'RepositoriesList' });
            }

            return response.message;
        });
    },
    logout ({ commit }) {
        StorageService.clear();
        router.push({ name: 'login' });
        commit('logout');
    },
    setLoading ({ commit }, data) {
        commit('changeLoading', data);
    }
};

// Mutations
const mutations = {
    login (state, data) {
        state.loggedIn = true;
        state.userInfos = data;
    },
    logout (state) {
        state.loggedIn = false;
        state.userInfos = null;
    },
    changeLoadingStatus (state, data) {
        state.userStateLoaded = data;
    },
    changeUserData(state, data) {
        state.userInfos = data;
    },
    changeLoading(state, data) {
        state.isSpinning = data;
    }
};

const user = {
    namespaced: true,
    getters,
    state,
    actions,
    mutations
};

export default user;
