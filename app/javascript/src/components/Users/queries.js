import { restCall, convertToFormData } from "../../utils/rest-helper";

function getMemberships(querykey, userId) {
  return restCall(`users/${userId}/commissions`).then((res) => res.data);
}
function getUsers(queryKey) {
  return restCall("users").then((res) => res.data);
}

function getUser(queryKey, id) {
  return restCall(`users/${id}`).then((res) => res.data);
}

function getUserType(queryKey, id) {
  return restCall(`user_types/${id}`).then((res) => res.data);
}

function getUserTypes() {
  return restCall("user_types").then((res) => res.data);
}

function createUser(data) {
  const formData = convertToFormData("user", data);
  return restCall(`users`, {
    method: "POST",
    data: formData,
  }).then((res) => res.data);
}

function updateUser(id, data) {
  const formData = convertToFormData("user", data);
  return restCall(`users/${id}`, {
    method: "PUT",
    data: formData,
  }).then((res) => res.data);
}

function removeUser(id) {
  return restCall(`users/${id}`, { method: "DELETE" });
}

export {
  getMemberships,
  getUser,
  getUsers,
  getUserType,
  getUserTypes,
  createUser,
  updateUser,
  removeUser,
};
