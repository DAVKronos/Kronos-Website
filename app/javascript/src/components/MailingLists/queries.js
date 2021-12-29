import { restCall } from "../../utils/rest-helper";

function getMailingList(queryKey, id) {
  return restCall(`mailinglists/${id}`).then((res) => res.data);
}

function getMailingLists() {
  return restCall("mailinglists").then((res) => res.data);
}

function createMailingList(data) {
  return restCall(`mailinglists`, {
    method: "POST",
    data: { mailinglist: data },
  }).then((res) => res.data);
}

function updateMailingList(id, data) {
  return restCall(`mailinglists/${id}`, {
    method: "PUT",
    data: { mailinglist: data },
  }).then((res) => res.data);
}

function removeMailingList(id) {
  return restCall(`mailinglists/${id}`, { method: "DELETE" });
}

export {
  getMailingLists,
  removeMailingList,
  updateMailingList,
  getMailingList,
  createMailingList,
};
