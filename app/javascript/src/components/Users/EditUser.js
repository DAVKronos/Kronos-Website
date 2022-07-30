import React from "react";
import { useQuery, useQueryCache } from "react-query";
import DefaultSpinner from "../Generic/Spinner";
import { useHistory } from "react-router-dom";
import EditObjectComponent from "../Generic/EditObjectComponent";
import { getUser, updateUser } from "./queries";
import UserForm, { adminUserFields } from "./UserForm";

const EditUserWithData = (props) => {
  const id = parseInt(props.match.params.id);
  const { isLoading, isError, data, error } = useQuery(["users", id], getUser);
  if (isLoading) {
    return <DefaultSpinner />;
  }
  return data && <EditUser user={data} />;
};

const EditUser = ({ user }) => {
  const queryCache = useQueryCache();
  const history = useHistory();
  const { id, name } = user;
  let editableFields = Object.fromEntries(
    adminUserFields
      .filter((fieldObject) => fieldObject.type != "file")
      .map((fieldObject) =>  [fieldObject.name, user[fieldObject.name]])
  );

  console.log(editableFields);

  const onSuccess = (savedUser) => {
    queryCache.setQueryData(["users", savedUser.id], savedUser);
    history.push(`/users/${savedUser.id}`);
  };

  return (
    <EditObjectComponent
      id={id}
      existingObject={editableFields}
      objectName="user"
      updateFunction={updateUser}
      onSuccess={onSuccess}
      FormComponent={UserForm}
    />
  );
};

export default EditUserWithData;
