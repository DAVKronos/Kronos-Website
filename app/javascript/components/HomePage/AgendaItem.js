import React from "react";
import {Row, Col} from "react-bootstrap";
import {Link} from "react-router-dom";
import format from '../../utils/date-format';

const AgendaItem = ({item}) => {
    const date = new Date(item.date);
    return <Row as={Link} to={`/agendaitems/${item.id}`}>
        <Col xs={2}><h5>
            <small>{format(date, 'ccc')}</small> <br/>
            {date.getDate()}<br/>
            <small>{format(date, 'MMM')}</small>
        </h5></Col>
        <Col xs={8}><h5>{item.name}</h5></Col>
    </Row>
};


export default AgendaItem;