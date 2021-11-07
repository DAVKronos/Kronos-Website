import React, {useContext} from "react";
import {Button, Card, ListGroup} from "react-bootstrap";
import {authContext} from "../../../utils/AuthContext";
import {useQuery, useQueryCache} from "react-query";
import {createSubscription, getSubscriptions, removeSubscription} from "../queries";
import DefaultSpinner from "../../Generic/Spinner";
import {formatDistanceToNow} from "../../../utils/date-format";
import {useTranslation} from "react-i18next";

const SubscriptionsCard = ({allowed, agendaItem}) => {
    const {t} = useTranslation('agendaItemPage');
    let body;
    if (!agendaItem.subscribe) {
        return null;
    }

    if (!allowed) {
        body = <React.Fragment>
            <Card.Header>{t('subscriptions.list')} </Card.Header>
            <Card.Body>{t('subscriptions.loginNotice')}</Card.Body>
        </React.Fragment>;
    } else {
        body = <Subscriptions agendaItem={agendaItem}/>;
    }
    return <Card className='card-margin-top'>
        {body}
    </Card>


}

const Subscriptions = ({agendaItem}) => {
    const {t, i18n} = useTranslation('agendaItemPage');
    const lang = i18n.language;
    const {user} = useContext(authContext);
    const queryCache = useQueryCache()
    const {isLoading, isError, data, error} = useQuery(['subscriptions', agendaItem.id], getSubscriptions);
    if (isLoading) {
        return <DefaultSpinner/>
    }
    const subscriptions = data;
    const userId = user && user.id
    const userSubscription = subscriptions.find(sub => sub.user_id === userId);

    const onClickUnsubscribe = () => {
        removeSubscription(agendaItem.id, userSubscription.id).then(()=> {
            queryCache.invalidateQueries(['subscriptions', agendaItem.id]);
        });
    }

    const onClickSubscribe = () => {
        createSubscription(agendaItem.id, {name: user.name}).then(()=> {
            queryCache.invalidateQueries(['subscriptions', agendaItem.id]);
        });
    }

    const subscriptionOpen = new Date(agendaItem.subscriptiondeadline) > new Date();

    const subscribeButton = userSubscription ?
        <Button variant='danger' onClick={onClickUnsubscribe}>{t('subscriptions.unsubscribe')}</Button> :
        <Button variant='success' onClick={onClickSubscribe}>{t('subscriptions.subscribe')}</Button>

        return <React.Fragment>
        <Card.Header>
            {t('subscriptions.list')} <br/>
            <small>{formatDistanceToNow(new Date(agendaItem.subscriptiondeadline), lang, true)}</small><br/>
            {subscriptionOpen && agendaItem.maxsubscription && <small>{t('subscriptions.placesLeft',{places: agendaItem.maxsubscription - subscriptions.length})}</small>}
        </Card.Header>
        <ListGroup variant="flush">
            {subscriptions && subscriptions.map(subscription => {
                return <ListGroup.Item key={subscription.id}>{subscription.name}</ListGroup.Item>;
            })}
        </ListGroup>
        <Card.Footer>
            {subscriptionOpen && subscribeButton}
            {!subscriptionOpen && t('subscriptions.closed')}
        </Card.Footer>
    </React.Fragment>;
}

export default SubscriptionsCard