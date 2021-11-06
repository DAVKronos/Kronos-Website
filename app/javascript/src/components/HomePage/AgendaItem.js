import React from "react";
import {Row, Col} from "react-bootstrap";
import {Link} from "react-router-dom";
import {format} from '../../utils/date-format';
import {useTranslation} from "react-i18next";

const AgendaItem = ({item}) => {
    const date = new Date(item.date);
    const { i18n } = useTranslation('homepage');
    const name = i18n.language === 'nl' ? item.name : item.name_en;
    return <Row as={Link} to={`/agendaitems/${item.id}`}>
        <Col xs={2}><h5>
            <small>{format(date, 'ccc', i18n.language)}</small> <br/>
            {date.getDate()}<br/>
            <small>{format(date, 'MMM', i18n.language)}</small>
        </h5></Col>
        <Col xs={8}><h5>{name}</h5></Col>
    </Row>
};


export default AgendaItem;