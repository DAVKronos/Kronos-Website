import {restCall, convertToFormData} from "../../utils/rest-helper";


function getPage(queryKey, id) {
    return restCall(`pages/${id}`).then(res => res.data)
}

function getPages(queryKey) {
    return restCall('pages').then(res => res.data)
}


function getPageByPageTag(queryKey, pagetag) {
    return restCall('pages').then(res => {
        return res.data.find(page => page.pagetag.indexOf(pagetag) > -1)
    });
}

function createPage(data) {
    console.log(data);
    const formData = convertToFormData('page', data);
    return restCall(`pages/`, {method: 'POST', data: formData}).then(res => res.data);
}

function updatePage(id, data) {
    const formData = convertToFormData('page', data);
    return restCall(`pages/${id}`, { method: 'PUT', data: formData }).then(res => res.data);;
}

function removePage(id) {
    return restCall(`pages/${id}`, {method: 'DELETE'});
}

export {getPage, getPages, getPageByPageTag, createPage, updatePage, removePage}