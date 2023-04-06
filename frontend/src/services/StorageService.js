class StorageService {
    insert (name, value) {
        localStorage.setItem(name, value);
    }

    get (name) {
        return localStorage.getItem(name);
    }

    delete (name) {
        localStorage.removeItem(name);
    }

    clear () {
        localStorage.clear();
    }
}

export default new StorageService();
