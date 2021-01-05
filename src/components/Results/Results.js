import React from 'react';
import MonthSwitcher from "../Generic/MonthSwitcher";
import {Card, Col, Row, Accordion, Button} from "react-bootstrap";
import {Link, useLocation} from "react-router-dom";
import {format} from "../../utils/date-format";
import {AgendaItemTypeName} from "../AgendaItems/AgendaItemType";
import EventsResults from "../AgendaItems/EventsResults";
import {BsChevronDown} from 'react-icons/bs';
import {useQuery} from "react-query";
import {getResults} from "./queries";
import {parseParams} from "../../utils/generic";
import DefaultSpinner from "../Generic/Spinner";


const Results = () => {
    const {search} = useLocation();
    const queryParams = parseParams(search);
    let date;
    if (queryParams.year && queryParams.month){
        // Fix for only year or month
        date = new Date(queryParams.year, queryParams.month - 1);
    } else {
        date = new Date();
    }

    const { isLoading, isError, data, error } = useQuery(['results', {year: date.getFullYear(), month: date.getMonth()}], getResults)
    const agendaItems = data;

    return (<React.Fragment>
        <Row>
            <Col md={12}>
                <h1>Uitslagen</h1>
            </Col>
        </Row>
        <Row style={{marginTop: 20}}>
            <Col md={12}>
                <MonthSwitcher date={date} />
            </Col>
        </Row>
        <Row style={{marginTop: 20}}>
            <Col md={12}>
                {isLoading && <DefaultSpinner/>}
                <Accordion defaultActiveKey="0">
                {agendaItems && agendaItems.map((item, index) => {
                    let itemDate = new Date(item.date);
                    return <Card key={item.id}>
                            <Accordion.Toggle as={Card.Header} eventKey={`${index}`} className='agenda-item result'>
                                <Row>
                                    <Col sm={2}><h4>{format(itemDate, 'd')} <small>{format(itemDate, 'ccc')}</small></h4></Col>
                                    <Col sm={1}><h4>{format(itemDate, 'p')}</h4></Col>
                                    <Col sm={9} style={{display: 'flex', justifyContent: 'space-between'}}>
                                        <h4>{item.name} <small><AgendaItemTypeName id={item.agendaitemtype_id}/></small></h4>
                                        <div style={{verticalAlign: 'middle'}}><BsChevronDown /></div>

                                    </Col>
                                </Row>
                            </Accordion.Toggle>
                            <Accordion.Collapse eventKey={`${index}`}>
                                <Card.Body>
                                    <EventsResults agendaItemId={item.id} />
                                    <div style={{display: 'flex', justifyContent: 'center'}}>
                                        <Link key={item.id} to={`/agendaitems/${item.id}`} >
                                            <Button>Evenementenpagina</Button>
                                        </Link>
                                    </div>
                                </Card.Body>
                            </Accordion.Collapse>
                        </Card>
                })}
                </Accordion>
            </Col>
        </Row>
    </React.Fragment>);
}

export default Results