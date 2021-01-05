import React, {useContext} from "react";
import {Button, Card, ListGroup} from "react-bootstrap";
import {authContext} from "../../../utils/AuthContext";
import {useQuery, useQueryCache} from "react-query";
import {createSubscription, getSubscriptions, removeSubscription} from "../queries";
import DefaultSpinner from "../../Generic/Spinner";
import {formatDistanceToNow} from "../../../utils/date-format";

const SubscriptionsCard = ({allowed, agendaItem}) => {
    let body;
    if (!agendaItem.subscribe) {
        return null;
    }

    if (!allowed) {
        body = <React.Fragment>
            <Card.Header>Inschrijflijst </Card.Header>
            <Card.Body>
                Je moet inloggen om inschrijvingen te zien of aan te vullen.
            </Card.Body>
        </React.Fragment>;
    } else {
        body = <Subscriptions agendaItem={agendaItem}/>;
    }
    return <Card style={{marginTop: 20}}>

        {body}
    </Card>


}

const Subscriptions = ({agendaItem}) => {
    const {auth} = useContext(authContext);
    const queryCache = useQueryCache()
    const {isLoading, isError, data, error} = useQuery(['subscriptions', agendaItem.id], getSubscriptions);
    if (isLoading) {
        return <DefaultSpinner/>
    }
    const subscriptions = data;
    const user = auth.data;
    const userSubscription = subscriptions.find(sub => sub.user_id === user.id);

    const onClickUnsubscribe = () => {
        removeSubscription(agendaItem.id, userSubscription.id).then(()=> {
            queryCache.invalidateQueries(['subscriptions', agendaItemId]);
        });
    }

    const onClickSubscribe = () => {
        createSubscription(agendaItem.id, {name: user.name}).then(()=> {
            queryCache.invalidateQueries(['subscriptions', agendaItemId]);
        });
    }


    const subscribeButton = userSubscription ?
        <Button variant='danger' onClick={onClickUnsubscribe}>Uitschrijven</Button> :
        <Button variant='success' onClick={onClickSubscribe}>Inschrijven</Button>

    return <React.Fragment>
        <Card.Header>
            Inschrijflijst <br/>
            <small>{formatDistanceToNow(new Date(agendaItem.subscriptiondeadline))}</small><br/>
            {agendaItem.maxsubscription && <small>{agendaItem.maxsubscription - subscriptions.length}</small>}
        </Card.Header>
        <ListGroup variant="flush">
            {subscriptions && subscriptions.map(subscription => {
                return <ListGroup.Item key={subscription.id}>{subscription.name}</ListGroup.Item>;
            })}
        </ListGroup>
        <Card.Footer>
            {subscribeButton}
        </Card.Footer>
    </React.Fragment>;
}

export default SubscriptionsCard