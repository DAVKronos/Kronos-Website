import axios from 'axios';

const API_HOST = '/api/v1';

const config = {
    headers: { 'Accept': 'application/json'},
};

function transformObject(obj) {
    return {
        ...obj,
        created_at: obj.created_at && new Date(obj.created_at),
        updated_at: obj.updated_at && new Date(obj.updated_at)
    }
}

function convertToFormData(objectName, data){
    const formData = new FormData();
    Object.keys(data).forEach((field) => {
        formData.append(`${objectName}[${field}]`, data[field]);
    })
    return formData
}

function getCSRFToken(){
    return document.querySelector("meta[name='csrf-token']").getAttribute("content");
}

function getCurrentUser() {
    return JSON.parse(sessionStorage.getItem('user'));
}

function getAuthHeader() {
    const user = getCurrentUser();
    if (user) {
        return { uid: user.uid, 'access-token': user['access-token'], client: user.client };
    } else {
        return {};
    }
}

function getConfig() {
    let cfg = {...config}
    // cfg.headers['X-CSRF-TOKEN'] = getCSRFToken();
    cfg.headers = {...cfg.headers, ...getAuthHeader()};
    return cfg;
}


function restCall(url, params = {}, method='get') {
    return axios.request({...getConfig(), url:`${API_HOST}/${url}`, method,  ...params});
}

class ObjectCollection {
    constructor(url) {
        this.objects = {};
        this.url = url;
    }

    getAll(params) {
        return restCall(this.url, params).then(response => {
            if (!response || !response.data) {
                return [];
            }

            return response.data.map(object => {
                return transformObject(object);
            });
        });
    }


    get(id, params) {
        if (this.objects[id]) {
            return Promise.resolve(this.objects[id]);
        }

        return restCall(`${this.url}/${id}`, params).then(response => {
            let object =  response.data ? transformObject(response.data) : null;
            if (object) {
                this.objects[object.id] = object;
            }
            return object;
        });
    }
}


function getAPIHostUrl(url) {
    return 'http://localhost:3000' + url;
}


export {
    restCall,
    API_HOST,
    getAPIHostUrl,
    transformObject,
    getConfig,
    convertToFormData
}