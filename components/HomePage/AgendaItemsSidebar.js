import React from "react";
import AgendaItem from "./AgendaItem";
import {Card, ListGroup} from 'react-bootstrap';
import {AgendaItemsCollection} from "../../utils/rest-helper";
import withData from "../../utils/withData";
import Spinner from "../Spinner";

function AgendaItemsSideBar({loading, data: agendaItems = []}) {
    let content;
    if (loading) {
        content =  <Spinner />;
    } else {
        content = agendaItems.map(item => (<ListGroup.Item key={item.id}><AgendaItem item={item}/></ListGroup.Item>));
    }

    return <Card className="side-panel">
        <Card.Header>Agenda</Card.Header>
        <ListGroup variant='flush'>
            {content}
        </ListGroup>
    </Card>
}



function sortAgendaItems(a, b) {
    return new Date(a.date) - new Date(b.date);
}

function agendaItems() {
    let now = new Date();
    const nextMonth  = new Date(now.getFullYear(), now.getMonth() + 1);
    let params = {'date[year]': nextMonth.getFullYear(), 'date[month]': nextMonth.getMonth()+1}
    return Promise.all([AgendaItemsCollection.getAll(), AgendaItemsCollection.getAll(params)])
        .then(([agendaItems1, agendaItems2]) => {
        return agendaItems1.concat(agendaItems2).filter(agendaItem => {
            const agendaDate = new Date(agendaItem.date);
            return agendaDate >= now;
        }).sort(sortAgendaItems);
    });
}


export default withData(AgendaItemsSideBar, () => agendaItems());