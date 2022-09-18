import React from "react";
import Spinner from "../Generic/Spinner";
import {useQuery} from "react-query";
import {getCurrentAnnouncement} from "./queries";
import { Jumbotron, Button } from "react-bootstrap";
import {Link} from "react-router-dom";

const Announcement = ({announcement, isLoading}) => {
    if (isLoading) {
        return <Spinner />;
    }

    

    return <Jumbotron style={{marginTop: 10, background: `#fff url('${announcement.background_url}') no-repeat right top`}}>
        <h1>{announcement.title}</h1>
        <p>{announcement.message}</p>
        <p>
            <Button to={announcement.url} as={Link}>Lees meer</Button>
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