import React from "react";
import { useQueryCache } from "react-query";
import { useHistory } from "react-router-dom";
import NewObjectComponent from "../Generic/NewObjectComponent";
import { createAlias } from "./queries";
import AliasForm from "./AliasForm";

const NewAlias = () => {
  const queryCache = useQueryCache();
  const history = useHistory();

  const onSuccess = (savedMailingList) => {
    queryCache.setQueryData(["aliases", savedMailingList.id], savedMailingList);
    queryCache.invalidateQueries("aliases");
    history.push(`/admin/aliases`);
  };

  return (
    <NewObjectComponent
      objectName="alias"
      createFunction={createAlias}
      onSuccess={onSuccess}
      FormComponent={AliasForm}
    />
  );
};

export default NewAlias;
