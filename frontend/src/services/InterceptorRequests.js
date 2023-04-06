import API from './API';

const setup = (store) => {
    API.interceptors.response.use(async function(response) {
        return response;
    }, function(err) {
        if (err.response.status === 422 || err.response.data.msg !== null) {
            store.dispatch('user/logout', true);
            return Promise.reject(err);
        }
    });
};

export default setup;
