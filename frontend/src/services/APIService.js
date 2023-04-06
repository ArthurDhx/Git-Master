import AuthHeader from "./AuthHeader";
import API from "./API";

class APIService {
    get(route) {
        const header = AuthHeader();

        return API.get(route, { headers: header })
            .then((response) => {
                return response.data;
            })
            .catch(() => {});
    }

    post(route, data) {
        const header = AuthHeader();

        return API.post(route, data, { headers: header })
            .then((response) => {
                return response.data;
            })
            .catch(() => {});
    }

    delete(route) {
        const header = AuthHeader();

        return API.delete(route, { headers: header })
            .then((response) => {
                return response.data;
            })
            .catch(() => {});
    }
}

export default new APIService();
