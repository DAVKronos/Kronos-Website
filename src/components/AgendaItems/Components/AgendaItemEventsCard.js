import {useQuery} from "react-query";
import {getAgendaitemEvents} from "../queries";
import DefaultSpinner from "../../Generic/Spinner";
import {Card, ListGroup} from "react-bootstrap";
import {format} from "../../../utils/date-format";
import React from "react";

const AgendaItemEventsCard = ({agendaItemId}) => {
    return <Card>
        <Card.Header>Programma</Card.Header>
        <AgendaItemEvents agendaItemId={agendaItemId}/>
    </Card>
}


const AgendaItemEvents = ({agendaItemId}) => {
    const {isLoading, isError, data, error} = useQuery(['agendaitemevents', agendaItemId], getAgendaitemEvents);
    const events = data;
    if (isLoading) {
        return <DefaultSpinner/>
    }

    if (!events || events.length === 0) {
        return <ListGroup variant="flush">
            <ListGroup.Item>
                Geen Programma
            </ListGroup.Item>
        </ListGroup>;
    }
    return <ListGroup variant="flush">
        {events.map(event => {
            let date = new Date(event.date);
            return <ListGroup.Item key={event.id}>{format(date, 'p')} {event.name}</ListGroup.Item>;
        })}
    </ListGroup>;

}

export default AgendaItemEventsCard