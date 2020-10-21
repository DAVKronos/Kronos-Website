import React from "react";
import {Card, Col, ListGroup, Row, Image} from 'react-bootstrap';
import format from '../../utils/date-format';
import {useQuery} from "react-query";
import DefaultSpinner from "../Spinner";
import {getUserBirthdays} from "./queries";
import {Link} from "react-router-dom";
import {getAPIHostUrl} from "../../utils/rest-helper";
import {useTranslation} from "react-i18next";



const UserBirthdays = () => {
    const { t } = useTranslation('homepage');
    const { isLoading, data} = useQuery('user_birthdays', getUserBirthdays);
    let content;
    if (isLoading) {
        content =  <DefaultSpinner />;
    } else if (data) {
        content = data.map((user) => {
            return <ListGroup.Item key={user.id}>
                <UserBirthday user={user}/>
            </ListGroup.Item>;
        });
    }

    return <Card className="side-panel">
        <Card.Header>{t('birthdays')}</Card.Header>
        <ListGroup variant='flush'>
            {content}
        </ListGroup>
    </Card>
}

const UserBirthday = ({user}) => {
    const [year, month, day] = user && user.birthdate && user.birthdate.split('-');
    const birthdate = new Date(year, month - 1, day);
    return <Row as={Link} to={`/users/${user.id}`} className='align-items-center'>
        <Col xs={2}><h5>
            {birthdate.getDate()}<br/>
            <small>{format(birthdate, 'MMM')}</small>
        </h5></Col>
        <Col xs={2}><Image roundedCircle src={user.avatar_url_thumb}/> </Col>
        <Col xs={7}><h5>{user.name}</h5></Col>
    </Row>
}

export default UserBirthdays;