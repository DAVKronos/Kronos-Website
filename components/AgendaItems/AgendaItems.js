import React from 'react'
import {Link} from "react-router-dom";
import {Row, Col, Nav, Card} from 'react-bootstrap';
import {AgendaItemsCollection, AgendaItemTypesCollection} from "../../utils/rest-helper";
import format from '../../utils/date-format';
import withData from "../../utils/withData";
import {AgendaItemTypeName} from "./AgendaItemType";
import MonthSwitcher from "../Generic/MonthSwitcher";


function AgendaItemsFilter({filter, data, onChangeFilter}){
    return <Nav variant="pills">
        <Nav.Item><Nav.Link active={filter == null}
                            onClick={() => onChangeFilter(null)}>All</Nav.Link></Nav.Item>
        {data && data.map(agendaItemType => {
            return <Nav.Item>
                <Nav.Link
                    active={filter === agendaItemType.id}
                    onClick={() => onChangeFilter(agendaItemType.id)}>
                    {agendaItemType.name}
                </Nav.Link>
            </Nav.Item>;
        })}
    </Nav>
}

const AgendaItemsFilterWithData = withData(AgendaItemsFilter, () =>  AgendaItemTypesCollection.getAll())




class AgendaItems extends React.Component {
    state = {
        agendaItems:[],
        date: new Date(),
        filter: null,
        searchMonth: null,
        searchYear: null
    }

    componentDidMount() {
        AgendaItemsCollection.getAll().then(agendaItems => {
            this.setState({agendaItems})
        })
    }

    handleChange = (date) => {
        let params = {};

        if (date) {
            params = {'date[year]': date.getFullYear(), 'date[month]': date.getMonth()+1}
        }

        AgendaItemsCollection.getAll(params).then(agendaItems => {
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

    onChangeFilter = (filter) => {
        if (this.state.filter !== filter) {
            this.setState({filter});
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

    renderMonthSwitcher() {
        let {date, searchMonth, searchYear} = this.state;
        return <MonthSwitcher date={date}
                              searchMonth={searchMonth}
                              searchYear={searchYear}
                              onChangeDate={this.changeDate}
                              onChangeSearchMonth={this.onChangeSearchMonth}
                              onChangeSearchYear={this.onChangeSearchYear}
                              onClickSearch={this.onClickSearch} />
    }


    renderItems() {
        let { agendaItems, filter} = this.state;
        if (filter) {
            agendaItems = agendaItems.filter(agendaItem => agendaItem.agendaitemtype_id === filter)
        }


        return agendaItems && agendaItems.map(item => {
            let itemDate = new Date(item.date);
            return <Link key={item.id} to={`/agendaitems/${item.id}`} className='agenda-item'><Card body style={{marginBottom: 10}}>
                <Row>
                    <Col sm={2}><h4>{format(itemDate, 'd')} <small>{format(itemDate, 'ccc')}</small></h4></Col>
                    <Col sm={1}><h4>{format(itemDate, 'p')}</h4></Col>
                    <Col sm={9}><h4>{item.name} <small><AgendaItemTypeName id={item.agendaitemtype_id}/></small></h4></Col>
                </Row>
            </Card></Link>
        });
    }

    render() {
        const {filter} = this.state;
        return (<React.Fragment>
            <Row>
                <Col md={12}>
                    <h1>Agenda</h1>
                </Col>
            </Row>
            <Row style={{marginTop: 20}}>
                <Col md={12}>
                    {this.renderMonthSwitcher()}
                </Col>
            </Row>
            <Row style={{marginTop: 20}}>
                <Col md={12}>
                    <AgendaItemsFilterWithData filter={filter} onChangeFilter={this.onChangeFilter}/>
                </Col>
            </Row>
            <Row style={{marginTop: 20}}>
                <Col md={12}>
                    {this.renderItems()}
                </Col>
            </Row>
        </React.Fragment>);
    }
}

export default AgendaItems;