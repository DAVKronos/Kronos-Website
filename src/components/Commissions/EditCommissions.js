import React from "react";
import { useQuery, useQueryCache } from "react-query";
import DefaultSpinner from "../Generic/Spinner";
import { useHistory } from "react-router-dom";
import EditObjectComponent from "../Generic/EditObjectComponent";
import { getCommission, updateCommission } from "./queries";
import CommissionForm from "./CommissionForm";

const EditCommissionWithData = (props) => {
  const id = parseInt(props.match.params.id);
  const { isLoading, isError, data, error } = useQuery(
    ["commissions", id],
    getCommission
  );
  if (isLoading) {
    return <DefaultSpinner />;
  }
  return data && <EditCommission commission={data} />;
};

const EditCommission = ({ commission }) => {
  const queryCache = useQueryCache();
  const history = useHistory();
  const { id, name, name_en, description, description_en } = commission;
  const editableFields = {
    name,
    name_en,
    description,
    description_en
  };
  const onSuccess = (savedCommission) => {
    queryCache.setQueryData(
      ["commission", savedCommission.id],
      savedCommission
    );
    history.push(`/commissions/${savedCommission.id}`);
  };

  return (
    <EditObjectComponent
      id={id}
      existingObject={editableFields}
      objectName="commission"
      updateFunction={updateCommission}
      onSuccess={onSuccess}
      FormComponent={CommissionForm}
    />
  );
};

export default EditCommissionWithData;
