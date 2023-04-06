import AuthHeader from './AuthHeader';
import StorageService from './StorageService';
import API from './API';

class AuthService {
    login (email, password) {
        return API.post('login', { email: email, password: password }).then(response => {
            response = response.data;
            if (response.message === null) {
                StorageService.insert('credentials', response.data.token);
                StorageService.insert('gitlabToken', response.data.user_infos.token_gitlab);
            }

            return response;
        }).catch(() => {});
    }

    getUserData () {
        const header = AuthHeader();

        return API.get('user/', { headers: header }).then(response => {
            return response.data;
        }).catch(() => {});
    }
}

export default new AuthService();
