import React from 'react';
import {ResultsCollection} from "../../utils/rest-helper";
import MonthSwitcher from "../Generic/MonthSwitcher";
import {Card, Col, Row, Accordion, Button} from "react-bootstrap";
import {Link} from "react-router-dom";
import format from "../../utils/date-format";
import {AgendaItemTypeName} from "../AgendaItems/AgendaItemType";
import EventsResults from "../AgendaItems/EventsResults";
import {BsChevronDown} from 'react-icons/bs';


class Results extends React.Component {
    state = {
        agendaItems:[],
        date: new Date(),
        filter: null,
        searchMonth: null,
        searchYear: null
    }
    componentDidMount() {
        ResultsCollection.getAll().then(agendaItems => {
            this.setState({agendaItems})
        })
    }

    handleChange = (date) => {
        let params = {};

        if (date) {
            params = {'date[year]': date.getFullYear(), 'date[month]': date.getMonth()+1}
        }

        ResultsCollection.getAll(params).then(agendaItems => {
            agendaItems = agendaItems.filter(agendaItem => {
                let agendaItemDate = new Date(agendaItem.date);
                return !date || agendaItemDate.getFullYear() === date.getFullYear() && agendaItemDate.getMonth() === date.getMonth();
            });

            this.setState({
                agendaItems
            })
        });
    }

    changeDate = (date) => {
        if (this.state.date !== date) {
            this.setState({date, loading:true});
            this.handleChange(date);
        }
    }

    onChangeSearchYear = (event) => {
        let searchYear = event.target.value;
        if (this.state.searchYear !== searchYear) {
            this.setState({searchYear})
        }
    }

    onChangeSearchMonth = (event) => {
        let searchMonth = event.target.value;
        if (this.state.searchMonth !== searchMonth) {
            this.setState({searchMonth})
        }
    }

    onClickSearch = () => {
        let {searchYear, searchMonth, date} = this.state;
        let month = date.getMonth();
        let year = date.getFullYear();
        let searchYearValue = searchYear !== null ? searchYear : year;
        let searchMonthValue = searchMonth !== null ?  searchMonth - 1 : month;
        let newDate = new Date(searchYearValue, searchMonthValue)
        this.setState({
            date: newDate,
            searchYear: null,
            searchMonth: null,
            loading: true
        });
        this.handleChange(newDate);

    }

    render() {
        let {date, searchMonth, searchYear, agendaItems} = this.state;
        return (<React.Fragment>
            <Row>
                <Col md={12}>
                    <h1>Uitslagen</h1>
                </Col>
            </Row>
            <Row style={{marginTop: 20}}>
                <Col md={12}>
                    <MonthSwitcher date={date}
                                   searchMonth={searchMonth}
                                   searchYear={searchYear}
                                   onChangeDate={this.changeDate}
                                   onChangeSearchMonth={this.onChangeSearchMonth}
                                   onChangeSearchYear={this.onChangeSearchYear}
                                   onClickSearch={this.onClickSearch}
                    />
                </Col>
            </Row>
            <Row style={{marginTop: 20}}>
                <Col md={12}>
                    <Accordion defaultActiveKey="0">
                    {agendaItems && agendaItems.map((item, index) => {
                        let itemDate = new Date(item.date);
                        return <Card key={item.id}>
                                <Accordion.Toggle as={Card.Header} eventKey={index} className='agenda-item result'>
                                    <Row>
                                        <Col sm={2}><h4>{format(itemDate, 'd')} <small>{format(itemDate, 'ccc')}</small></h4></Col>
                                        <Col sm={1}><h4>{format(itemDate, 'p')}</h4></Col>
                                        <Col sm={9} style={{display: 'flex', justifyContent: 'space-between'}}>
                                            <h4>{item.name} <small><AgendaItemTypeName id={item.agendaitemtype_id}/></small></h4>
                                            <div style={{verticalAlign: 'middle'}}><BsChevronDown /></div>

                                        </Col>
                                    </Row>
                                </Accordion.Toggle>
                            <Accordion.Collapse eventKey={index}>
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
}

export default Results