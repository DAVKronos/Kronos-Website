import React, { useState } from "react";
import { useQuery, useQueryCache } from "react-query";
import { Table, Button } from "react-bootstrap";
import { getAnnouncements, removeAnnouncement } from "./queries";
import { Link } from "react-router-dom";
import { Can } from "../../utils/auth-helper";
import { useTranslation } from "react-i18next";
import DefaultSpinner from "../Generic/Spinner";
import { getCommissions } from "../Commissions/queries";
import ListObjectsComponent from "../Generic/ListObjectsComponent";

const Announcements = () => {
  let {
    isLoading,
    isError,
    data: announcements,
    error,
  } = useQuery("announcements", getAnnouncements);

  const columns = ["title"];
  const removeFunction = (id) => {
    return removeAnnouncement(id).then(() => {
      queryCache.invalidateQueries(["announcements"], { exact: true });
    });
  };
  const [removing, setRemoving] = useState(null);
  const { t } = useTranslation("generic");
  const announcementCount = announcements ? announcements.length : 0;
  const queryCache = useQueryCache();
  
  return (
    <React.Fragment>
      <h1>{t("models:modelNames.announcement", { count: announcementCount })}</h1>
      <ListObjectsComponent
        columns={columns}
        objects={announcements}
        removeFunction={removeFunction}
        modelName="announcement"
        baseUrl="/admin/announcements"
      />
      {isLoading && <DefaultSpinner />}
      <Can I="create" a={"Mailinglist"}>
        <Button as={Link} to="/admin/announcements/new">
          {t("addModel", {
            model: t("models:modelNames.announcement", { count: 0 }),
          })}
        </Button>
      </Can>
    </React.Fragment>
  );
};

export default Announcements;
