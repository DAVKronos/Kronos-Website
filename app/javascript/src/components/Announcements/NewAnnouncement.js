import React from "react";
import {useQueryCache} from "react-query";
import {useHistory} from "react-router-dom";
import NewObjectComponent from "../Generic/NewObjectComponent";
import { createAnnouncement} from "./queries";
import AnnouncementForm from "./AnnouncementForm";

const NewAnnouncement = () => {

    const queryCache = useQueryCache();
    const history = useHistory();

    
    const onSuccess = (savedAnnouncement) => {
        queryCache.setQueryData(['announcements', savedAnnouncement.id], savedAnnouncement)
        queryCache.invalidateQueries('announcements');
        history.push(`/announcements/${savedAnnouncement.id}`)
    }

    return <NewObjectComponent
        objectName='announcement'
        createFunction={createAnnouncement}
        onSuccess={onSuccess}
        FormComponent={AnnouncementForm}
    />
}

export default NewAnnouncement