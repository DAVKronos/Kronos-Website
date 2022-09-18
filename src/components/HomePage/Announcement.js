import React, {useState} from "react";
import Spinner from "../Generic/Spinner";
import {useQuery} from "react-query";
import {getCurrentAnnouncement} from "./queries";
import { Jumbotron, Button } from "react-bootstrap";
import {Link} from "react-router-dom";
import { getLocalSettings, setLocalSettings } from "../../utils/local-settings";
import {useTranslation} from "react-i18next";

function hideAnnouncement(id) {
    const hiddenAnnouncements = getLocalSettings('hiddenAnnouncements') || []

    hiddenAnnouncements.push(id)
    setLocalSettings('hiddenAnnouncements', hiddenAnnouncements);
}




const Announcement = ({announcement, isLoading}) => {
    const [hidden, setHidden] = useState(false);
    const {t} = useTranslation('homepage');
    if (hidden) {
        return null;
    }

    if (isLoading) {
        return <Spinner />;
    }

    const onClick = () => {
        hideAnnouncement(announcement.id)
        setHidden(true);
    }

    return <Jumbotron style={{marginTop: 10, background: `#fff url('${announcement.background_url}') no-repeat right top`}}>
        <h1>{announcement.title}</h1>
        <p>{announcement.message}</p>
        <p>
            <Button to={announcement.url} as={Link}>{t('readMore')}</Button>
            <Button onClick={onClick}>{t('hide')}</Button>
        </p>
    </Jumbotron>;
}


const AnnouncementWithData = () => {
    const { isLoading, isError, data, error } = useQuery(['announcements', 'current'], getCurrentAnnouncement)

    const announcements = data
    if (!announcements || announcements.length == 0) {
        return null;
    }

    return <Announcement announcement={announcements[0]} isLoading={isLoading}/>;
}

export default AnnouncementWithData