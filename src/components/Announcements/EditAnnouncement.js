import React from "react";
import {useQuery, useQueryCache} from "react-query";
import DefaultSpinner from "../Generic/Spinner";
import {useHistory} from "react-router-dom";
import EditObjectComponent from "../Generic/EditObjectComponent";
import {getAnnouncement, updateAnnouncement} from "./queries";
import AnnouncementForm from "./AnnouncementForm";

const EditAnnouncementWithData = (props) => {
    const id = parseInt(props.match.params.id);;
    const { isLoading, isError, data, error } = useQuery(['announcements', id], getAnnouncement);
    if (isLoading) {
        return <DefaultSpinner />;
    }
    return data && <EditAnnouncement announcement={data} />
}

const EditAnnouncement = ({announcement}) => {

    const queryCache = useQueryCache();
    const history = useHistory();
    const {id, title, message, url, background, starts_at, ends_at} = announcement;

    const editableFields = {title, message, url, background, starts_at, ends_at};
    const onSuccess = (savedAnnouncement) => {
        queryCache.setQueryData(['announcements', savedAnnouncement.id], savedAnnouncement);
        queryCache.invalidateQueries(['announcements'], {exact: true});
        
        history.push(`/admin/announcements`);
        
    }

    return <EditObjectComponent
        id={id}
        existingObject={editableFields}
        objectName='announcement'
        updateFunction={updateAnnouncement}
        onSuccess={onSuccess}
        FormComponent={AnnouncementForm}
    />
}

export default EditAnnouncementWithData