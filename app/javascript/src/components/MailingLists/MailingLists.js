import React, { useState } from "react";
import { useQuery, useQueryCache } from "react-query";
import { Table, Button } from "react-bootstrap";
import { getMailingLists, removeMailingList } from "./queries";
import { Link } from "react-router-dom";
import { Can } from "../../utils/auth-helper";
import { useTranslation } from "react-i18next";
import DefaultSpinner from "../Generic/Spinner";
import { getCommissions } from "../Commissions/queries";
import ListObjectsComponent from "../Generic/ListObjectsComponent";

const MailingLists = () => {
  let {
    isLoading,
    isError,
    data: mailingLists,
    error,
  } = useQuery("mailinglists", getMailingLists);
  const { isLoading: commissionsLoading, data: commissions } = useQuery(
    "commissions",
    getCommissions
  );

  mailingLists =
    mailingLists &&
    mailingLists.map((mailingList) => {
      let commission_id = "Geen";
      if (mailingList.commission_id) {
        if (commissionsLoading) {
          commission_id = <DefaultSpinner inline size="sm" />;
        } else {
          const commission = commissions.find(
            (v) => v.id == mailingList.commission_id
          );
          commission_id = commission && commission.name;
        }
      }
      const local_part = `${mailingList.local_part}@kronos.nl`;
      return { ...mailingList, commission_id, local_part };
    });
  const columns = ["name", "description", "local_part", "commission_id"];
  const removeFunction = (id) => {
    return removeMailingList(id).then(() => {
      queryCache.invalidateQueries(["mailinglists"], { exact: true });
    });
  };
  const [removing, setRemoving] = useState(null);
  const { t } = useTranslation("generic");
  const mailingListCount = mailingLists ? mailingLists.length : 0;
  const queryCache = useQueryCache();
  
  return (
    <React.Fragment>
      <h1>{t("models:modelNames.mailingList", { count: mailingListCount })}</h1>
      <ListObjectsComponent
        columns={columns}
        objects={mailingLists}
        removeFunction={removeFunction}
        modelName="mailingList"
        baseUrl="/admin/mailinglists"
      />
      {isLoading && <DefaultSpinner />}
      <Can I="create" a={"Mailinglist"}>
        <Button as={Link} to="/admin/mailinglists/new">
          {t("addModel", {
            model: t("models:modelNames.mailingList", { count: 0 }),
          })}
        </Button>
      </Can>
    </React.Fragment>
  );
};

export default MailingLists;
