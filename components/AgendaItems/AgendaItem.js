import React from 'react';
import {Card, Col, ListGroup, Row} from 'react-bootstrap';
import {AgendaItemTypeName} from './AgendaItemType';
import {BsGeoAlt, BsClock, BsList, BsLink} from 'react-icons/bs';

import format from '../../utils/date-format';
import EventsResults from "./EventsResults";
import {useQuery} from "react-query";
import {getAgendaitem, getAgendaitemEvents} from "./queries";
import DefaultSpinner from "../Spinner";


const AgendaItemEvents = ({agendaItemId}) => {
    const { isLoading, isError, data, error } = useQuery(['agendaitemevents', agendaItemId], getAgendaitemEvents);
    const events = data;
    if (isLoading) {
        return <DefaultSpinner />
    }

    if (!events || events.length === 0){
        return "Geen Programma";
    }
    return <ListGroup variant="flush">
        {events.map(event => {
            let date = new Date(event.date);
            return <ListGroup.Item key={event.id}>{format(date, 'p')} {event.name}</ListGroup.Item>;
        })}
    </ListGroup>;

}

function AgendaItem(props) {
    const id = props.match.params.id;
    const { isLoading, isError, data, error } = useQuery(['agendaitems', id], getAgendaitem)
    let agendaItem = data;
    if (!agendaItem) {
        return null;
    }

    let date = new Date(agendaItem.date);
    return <React.Fragment>
        <Row>
            <Col sm={12}>
                <h1>{agendaItem.name} <small><AgendaItemTypeName id={agendaItem.agendaitemtype_id} /></small></h1>
            </Col>
        </Row>
        <Row>
            <Col md={8}>
                <Row>
                    <Col xs={1}><BsClock/></Col>
                    <Col xs={11}>{format(date, 'PPP p')}</Col>
                </Row>
                {agendaItem.location && <Row>
                    <Col xs={1}><BsGeoAlt/></Col>
                    <Col xs={11}>{agendaItem.location}</Col>
                </Row>
                }
                {agendaItem.url && <Row>
                    <Col xs={1}><BsLink/></Col>
                    <Col xs={11}><a href={`http://${agendaItem.url}`}>{agendaItem.url}</a></Col>
                </Row>
                }
                {agendaItem.commission && <Row>
                    <Col xs={1}><BsGeoAlt/></Col>
                    <Col xs={11}>{agendaItem.commission}</Col>
                </Row>}
                <Row>
                    <Col xs={1}><BsList/></Col>
                    <Col xs={11}>{agendaItem.description}</Col>
                </Row>
                <Row><Col>
                    <h2>Results</h2>
                    <EventsResults agendaItemId={agendaItem.id}/>
                </Col></Row>
            </Col>
            <Col md={4}>
                <Card>
                    <Card.Header>Programma</Card.Header>
                    <AgendaItemEvents agendaItemId={agendaItem.id}/>
                </Card>
                <Card style={{marginTop: 20}}>
                    <Card.Header>Inschrijflijst</Card.Header>
                    <Card.Body>Je moet inloggen om inschrijvingen te zien of aan te vullen.</Card.Body>
                </Card>
            </Col>
        </Row>
    </React.Fragment>
}

export default AgendaItem