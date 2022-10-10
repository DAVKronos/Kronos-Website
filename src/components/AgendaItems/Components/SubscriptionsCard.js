import React, {useState, useContext} from "react";
import {Col, Button, Card, ListGroup, Form} from "react-bootstrap";
import {authContext} from "../../../utils/AuthContext";
import {useQuery, useQueryCache} from "react-query";
import {createSubscription, getSubscriptions, removeSubscription} from "../queries";
import DefaultSpinner from "../../Generic/Spinner";
import {formatDistanceToNow} from "../../../utils/date-format";
import {useTranslation} from "react-i18next";

import {Can} from '../../../utils/auth-helper';
import {subject} from "@casl/ability";

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
    const [text, setText] = useState('')
    const queryCache = useQueryCache()
    const {isLoading, isError, data, error} = useQuery(['agendaitems', agendaItem.id, 'subscriptions'], getSubscriptions);
    if (isLoading) {
        return <DefaultSpinner/>
    }
    const subscriptions = data;
    const userId = user && user.id
    const userSubscription = subscriptions.find(sub => sub.user_id === userId);

    const onClickUnsubscribe = (subcriptionId) => {
        removeSubscription(agendaItem.id, subcriptionId).then(()=> {
            queryCache.invalidateQueries(['agendaitems', agendaItem.id, 'subscriptions']);
        });
    }

    const onClickSubscribe = () => {
        createSubscription(agendaItem.id, {name: user.name, comment: text}).then(()=> {
            queryCache.invalidateQueries(['agendaitems', agendaItem.id, 'subscriptions']);
        });
    }

    const subscriptionOpen = new Date(agendaItem.subscriptiondeadline) > new Date();

    const subscribeButton = userSubscription ?
        <React.Fragment>
            <Button variant='danger' onClick={() => onClickUnsubscribe(userSubscription.id)}>{t('subscriptions.unsubscribe')}</Button>
        </React.Fragment>:
        <React.Fragment>
            <Col md={8} style={{display: 'flex', alignItems: 'center'}}>
                <Form.Control as="textarea" value={text} onChange={e => setText(e.target.value)} placeholder={t('comment')} />
            </Col>
            <Button variant='success' onClick={onClickSubscribe}>{t('subscriptions.subscribe')}</Button>
        </React.Fragment>

    return <React.Fragment>
        <Card.Header>
            {t('subscriptions.list')} <br/>
            <small>{formatDistanceToNow(new Date(agendaItem.subscriptiondeadline), lang, true)}</small><br/>
            {subscriptionOpen && agendaItem.maxsubscription && <small>{t('subscriptions.placesLeft',{places: agendaItem.maxsubscription - subscriptions.length})}</small>}
        </Card.Header>
        <ListGroup variant="flush">
            {subscriptions && subscriptions.map(subscription => {
                return <ListGroup.Item key={subscription.id} style={{alignItems: "center"}}>
                    <div>{subscription.name}</div>
                    <small>{subscription.comment}</small>
                    <br/>
                    <Can I='destroy' this={subject('Subscription', subscription)}>
                        <Button  size='sm' variant='danger' onClick={() => onClickUnsubscribe(subscription.id)}>{t('subscriptions.unsubscribe')}</Button>
                    </Can><br/>

                </ListGroup.Item>;
            })}
        </ListGroup>
        <Card.Footer>
            {subscriptionOpen && subscribeButton}
            {!subscriptionOpen && t('subscriptions.closed')}
        </Card.Footer>
    </React.Fragment>;
}

export default SubscriptionsCard