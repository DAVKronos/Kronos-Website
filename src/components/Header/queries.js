import {restCall} from "../../utils/rest-helper";


function getPages() {
    return restCall('pages').then(res => res.data)
}

function resetPassword(email) {
    return restCall(`auth/password`, { method: "POST", data: { email, redirect_url: "users/password/edit" }});
  }

export {getPages, resetPassword}