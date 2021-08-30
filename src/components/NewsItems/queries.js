import {convertToFormData, restCall} from "../../utils/rest-helper";


function getNewsItem(queryKey, id) {
    return restCall(`newsitems/${id}`).then(res => res.data)
}

function createNewsItem(data) {
    const formData = convertToFormData('newsitem', data);
    return restCall(`newsitems/`, {method: 'POST', data: formData}).then(res => res.data);
}

function updateNewsItem(id, data) {
    const formData = convertToFormData('newsitem', data);
    return restCall(`newsitems/${id}`, {method: 'PUT', data: formData}).then(res => res.data);
}

function removeNewsItem(id) {
    return restCall(`newsitems/${id}`, {method: 'DELETE'});
}

function getNewsItemComments(queryKey, newsItemId) {
    return restCall(`newsitems/${newsItemId}/comments`).then(res => res.data);
}

function removeNewsItemComment(newsItemId, id) {
    return restCall(`newsitems/${newsItemId}/comments/${id}`, {method: 'DELETE'});
}

function createNewsItemComment(newsItemId, data) {
    return restCall(`newsitems/${newsItemId}/comments`, {method: 'POST', data: {comment: data}}).then(res => res.data);
}

export {getNewsItem, getNewsItemComments, createNewsItem, updateNewsItem, removeNewsItem, removeNewsItemComment, createNewsItemComment}