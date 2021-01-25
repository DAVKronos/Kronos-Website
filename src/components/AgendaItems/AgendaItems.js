import React, {useState} from 'react'
import {Link, useLocation} from "react-router-dom";
import {Row, Col, Nav, Card, Button} from 'react-bootstrap';
import {format} from '../../utils/date-format';
import {AgendaItemTypeName} from "./AgendaItemType";
import MonthSwitcher from "../Generic/MonthSwitcher";
import {useQuery} from "react-query";
import {getAgendaitems, getAgendaitemTypes} from "./queries";
import {parseParams} from "../../utils/generic";
import DefaultSpinner from "../Generic/Spinner";
import {Can} from "../../utils/auth-helper";
import {useTranslation} from "react-i18next";


function AgendaItemsFilter({filter, onChangeFilter}){
    const {t} = useTranslation('generic');
    const { isLoading, isError, data, error } = useQuery('agendaitemtypes', getAgendaitemTypes)
    return <Nav variant="pills">
        <Nav.Item key='all'>
            <Nav.Link active={filter == null} onClick={() => onChangeFilter(null)}>
                {t('allItems')}
            </Nav.Link>
        </Nav.Item>
        {data && data.map(agendaItemType => {
            return <Nav.Item key={agendaItemType.id}>
                <Nav.Link
                    active={filter === agendaItemType.id}
                    onClick={() => onChangeFilter(agendaItemType.id)}>
                    {agendaItemType.name}
                </Nav.Link>
            </Nav.Item>;
        })}
    </Nav>
}


const AgendaItems = () => {
    const {search} = useLocation();
    const {t} = useTranslation('generic');
    const queryParams = parseParams(search);
    let date;
    if (queryParams.year && queryParams.month){
        // Fix for only year or month
        date = new Date(queryParams.year, queryParams.month - 1);
    } else {
        date = new Date();
    }
    const [filter, setFilter] = useState(null);

    const { isLoading, isError, data, error } = useQuery(['agendaitems', {year: date.getFullYear(), month: date.getMonth()}], getAgendaitems)

    const onChangeFilter = (newFilter) => {
        if (filter !== newFilter) {
            setFilter(newFilter);
        }
    }

    let agendaItems = data;
    if (filter) {
        agendaItems = agendaItems.filter(agendaItem => agendaItem.agendaitemtype_id === filter)
    }
    return (<React.Fragment>
        <Row>
            <Col md={12}>
                <h1>{t('agendaItemPage:header')}</h1>
            </Col>
        </Row>
        <Row className="row-margin">
            <Col md={12}>
                <MonthSwitcher date={date} />
            </Col>
        </Row>
        <Row className="row-margin">
            <Col md={12}>
                <AgendaItemsFilter filter={filter} onChangeFilter={onChangeFilter}/>
            </Col>
        </Row>
        <Row className="row-margin">
            <Col md={12}>
                {isLoading && <DefaultSpinner/>}
                {agendaItems && agendaItems.map(item => {
                    let itemDate = new Date(item.date);
                    return <Link key={item.id} to={`/agendaitems/${item.id}`} className='agenda-item'>
                        <Card body className="agenda-item-card">
                            <Row>
                                <Col sm={2}><h4>{format(itemDate, 'd')} <small>{format(itemDate, 'ccc')}</small></h4></Col>
                                <Col sm={1}><h4>{format(itemDate, 'p')}</h4></Col>
                                <Col sm={9}><h4>{item.name} <small><AgendaItemTypeName id={item.agendaitemtype_id}/></small></h4></Col>
                            </Row>
                        </Card>
                    </Link>
                })}
            </Col>
        </Row>
        <Can I='create' a={'Agendaitem'}>
            <Button as={Link} to='/agendaitems/new'>{t('addModel', {model: t('models:modelNames.agendaItem', {count: 0})})}</Button>
        </Can>
    </React.Fragment>);
}

export default AgendaItems;