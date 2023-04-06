class ImgService {

    uploadImage(image) {
        const formdata = new FormData();
        formdata.append('image', image);
        return fetch('https://api.imgur.com/3/image/', {
            method: 'post',
            headers: {
                Authorization: 'Client-ID ebb8b1cd6fa52ea'
            },
            body: formdata
        }).then(data => data.json().then(
            (data) => {
                return data.data.link;
            }
        )).catch(() => {
            return 'error';
        });
    }
}

export default new ImgService();
