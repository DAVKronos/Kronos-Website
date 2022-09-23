import {useQuery, useQueryCache} from "react-query";
import {createEvent, deleteEvent, getAgendaitemEvents, getEventTypes} from "../queries";
import DefaultSpinner from "../../Generic/Spinner";
import {Button, Card, Col, Form, ListGroup, Row} from "react-bootstrap";
import {format} from "../../../utils/date-format";
import React, {useState} from "react";
import {subject} from "@casl/ability";
import {Can} from "../../../utils/auth-helper";
import {BsPlus, BsTrash} from 'react-icons/bs';
import {FieldControl} from "../../Generic/FormField";
import {useTranslation} from "react-i18next";

const AgendaItemEventsCard = ({agendaItemId, agendaItemTypeId}) => {
    const {t} = useTranslation('models');
    return <Card>
        <Card.Header>{t('modelNames.event', {count: 0})}</Card.Header>
        <AgendaItemEvents agendaItemId={agendaItemId} agendaItemTypeId={agendaItemTypeId}/>
    </Card>;
}

const AddEventForm = ({agendaItemId, agendaItemTypeId}) => {
    const {data: eventTypes} = useQuery(['agendaitemtype_eventtypes', agendaItemTypeId], getEventTypes);
    const queryCache = useQueryCache();
    const [values, setValues] = useState({});    

    const setEventTypeValue = (eventtype_id) => {
        setValues({...values, eventtype_id})
    }

    const setDateValue = (date) => {
        setValues({...values, date})
    }

    const onClickAddEvent = () => {
        createEvent(agendaItemId, values).then(() => {
            queryCache.invalidateQueries(['agendaitemevents', agendaItemId]);
            setValues({});
        })
    }

    const currentEventType = values.eventtype_id && eventTypes.find(event => event.id === values.eventtype_id);
    const hasDistanceInFormula = currentEventType && currentEventType.formula.includes('$distance')

    return <Form>
        <Form.Row>
            <Col sm={9} style={{padding: '5px'}}>
                <FieldControl type="time"
                              required
                              setValue={setDateValue}
                              value={values.date}
                              placeholder="Time" />
            </Col>
            <Col sm={9} style={{padding: '5px'}}>
                <FieldControl type="reference"
                              itemQuery={[['agendaitemtype_eventtypes', agendaItemTypeId], getEventTypes]}
                              required
                              setValue={setEventTypeValue}
                              value={values.eventtype_id}
                />
            </Col>
            {hasDistanceInFormula && <Col sm={9} style={{padding: '5px'}}>
                <Form.Control placeholder="Distance" />
            </Col>
            }
            <Col style={{padding: '5px'}} className="align-self-end d-flex flex-row-reverse">
                <Button  variant={'success'} style={{margin: 0}} onClick={onClickAddEvent}>
                    <BsPlus/>
                </Button>
            </Col>
        </Form.Row>
    </Form>
}


const AgendaItemEvents = ({agendaItemId, agendaItemTypeId}) => {
    const [editing, setEditing] = useState(false);
    const {t} = useTranslation('generic');
    const queryCache = useQueryCache();
    const {isLoading, isError, data, error} = useQuery(['agendaitemevents', agendaItemId], getAgendaitemEvents);
    const events = data;
    if (isLoading) {
        return <DefaultSpinner/>
    }

    const onClickRemove = (id) => {
        deleteEvent(agendaItemId, id).then(() => {
            queryCache.invalidateQueries(['agendaitemevents', agendaItemId]);
        });
    }

    let eventList;

    if (!events || events.length === 0) {
        eventList =
            <ListGroup.Item>
                {t('models:modelNames.no_events', {count: 0})}
            </ListGroup.Item>

    } else {
        eventList = events.map(event => {
            let date = new Date(event.date);
            return <ListGroup.Item key={event.id} className={"d-flex align-items-center"}>
                {format(date, 'p')} {event.name}
                {editing && <Can I='delete' this={subject('Event', event)}>
                    <Button className={"ml-auto"} size={'sm'} variant={'danger'} onClick={() => onClickRemove(event.id)}>
                        <BsTrash/>
                    </Button>
                </Can>}
            </ListGroup.Item>;
        })
    }
    return <React.Fragment>
        <ListGroup variant="flush">
        {eventList}
        {editing && <ListGroup.Item key={'new'}>
            <AddEventForm agendaItemTypeId={agendaItemTypeId} agendaItemId={agendaItemId} />

        </ListGroup.Item>}
    </ListGroup>
    <Card.Footer>
        <Can I={'create'} an={'Event'}>
            <Button onClick={() => setEditing(!editing)}>
                {editing && t('cancel')}
                {!editing && `${t('editModel', {model: t('models:modelNames.event', {count: 0})})}`}
        </Button>
        </Can>
    </Card.Footer>
    </React.Fragment>;

}

export default AgendaItemEventsCard