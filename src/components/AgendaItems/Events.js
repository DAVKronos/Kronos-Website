import React, {useState} from "react";
import {useQuery, useQueryCache} from "react-query";
import {getAgendaitemEvents} from "./queries";
import DefaultSpinner from "../Generic/Spinner";
import {Button, Card, Col, Form, } from "react-bootstrap";
import {EventResults} from "./EventsResults";
import {FieldControl} from "../Generic/FormField";
import {BsPlus} from "react-icons/bs";
import {getUsers} from "../Users/queries";
import {createResult} from "../Results/queries";
import {useTranslation} from "react-i18next";
import {Can} from "../../utils/auth-helper";


const AddResult = ({eventId, agendaItemId}) => {
    const {t} = useTranslation('generic');
    const {isLoading: usersLoading, data:users, } = useQuery(['users'], getUsers);
    const queryCache = useQueryCache();
    const [creating, setCreating] = useState(false);

    const [values, setValues] = useState({});

    const setPlaceValue = (place) => {
        setValues({...values, place})
    }

    const setUserIdValue = (user_id) => {
        setValues({...values, user_id})
    }

    const setResultValue = (result) => {
        setValues({...values, result})
    }

    const onClickAddResult = () => {
        createResult(eventId, values).then(() => {
            queryCache.invalidateQueries(['agendaitemevents', agendaItemId]);
            setValues({});
        })
    }


    return <Form>
        <Form.Row>
            <Col sm={3} style={{padding: '0 5px'}}>
                <FieldControl type="reference"
                              required
                              disabled={creating}
                              itemQuery={[['users'], getUsers]}
                              setValue={setUserIdValue}
                              value={values.user_id}
                              placeholder="User" />
            </Col>
            <Col sm={3} style={{padding: '0 5px'}}>
                <FieldControl type="number"
                              setValue={setPlaceValue}
                              value={values.place}
                              disabled={creating}
                              placeholder="Place"
                />
            </Col>
            <Col sm={3} style={{padding: '0 5px'}}>
                <FieldControl type="text"
                              required
                              setValue={setResultValue}
                              value={values.result}
                              disabled={creating}
                              placeholder="Result"
                />
            </Col>
            <Col style={{padding: '0 5px'}} className="align-self-end d-flex flex-row-reverse">
                <Button variant={'success'} disabled={creating} style={{margin: 0}} onClick={onClickAddResult}>
                    <BsPlus/>
                    {t("generic:addModel", {
                model: t("models:modelNames.result", { count: 1 }),
              })}
                </Button>
            </Col>
        </Form.Row>
    </Form>
}

const Events = ({match}) => {
    const agendaItemId = match.params.id;
    const {t} = useTranslation('models');
    const {isLoading: eventsLoading, data:events, } = useQuery(['agendaitemevents', agendaItemId], getAgendaitemEvents);


    return <div>
        <h1>{t('modelNames.event')} {t('modelNames.result_plural')}</h1>
        {eventsLoading && <DefaultSpinner />}
        {events && events.map((event) => {
            return <Card key={event.id} style={{marginBottom: 10}}>
                <Card.Body>
                    <EventResults event={event}/>
                </Card.Body>
                <Can I="create" a="Result">
                    <Card.Footer>
                        <AddResult agendaItemId={agendaItemId} eventId={event.id}/>
                    </Card.Footer>
                </Can>
            </Card>
        })}

    </div>;
}

export default Events