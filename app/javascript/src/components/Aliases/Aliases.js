import React, { useState } from "react";
import { useQuery, useQueryCache } from "react-query";
import { Table, Button } from "react-bootstrap";
import { Link } from "react-router-dom";
import { Can } from "../../utils/auth-helper";
import { useTranslation } from "react-i18next";
import DefaultSpinner from "../Generic/Spinner";
import { getAliases, removeAlias } from "./queries";
import ListObjectsComponent  from "../Generic/ListObjectsComponent";

const Aliases = () => {
  const {
    isLoading,
    isError,
    data: aliases,
    error,
  } = useQuery("aliases", getAliases);
  const queryCache = useQueryCache();
  
  const columns = ["name", "emailaddress", "description"];
  const removeFunction = async (id) => {
    await removeAlias(id);
    queryCache.invalidateQueries(["aliases"], { exact: true });
  };
  const { t } = useTranslation("generic");
  const aliasCount = aliases ? aliases.length : 0;
  return (
    <React.Fragment>
      <h1>{t("models:modelNames.alias", { count: aliasCount })}</h1>
      <ListObjectsComponent
        columns={columns}
        objects={aliases}
        removeFunction={removeFunction}
        modelName="alias"
        baseUrl="/admin/aliases"
      />
      {isLoading && <DefaultSpinner />}
      <Can I="create" a={"Alias"}>
        <Button as={Link} to="/admin/aliases/new">
          {t("addModel", { model: t("models:modelNames.alias", { count: 0 }) })}
        </Button>
      </Can>
    </React.Fragment>
  );
};

export default Aliases;
