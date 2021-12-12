import React from "react";
import AgendaItem from "./AgendaItem";
import {Card, ListGroup} from 'react-bootstrap';
import {useQuery} from "react-query";
import {getAgendaitems} from "../AgendaItems/queries";
import DefaultSpinner from "../Generic/Spinner";

function AgendaItemsSideBar() {
    const { isLoading, isError, data, error } = useQuery('agendaitems', agendaItems)
    const agendaitems = data && data.filter(agendaitem =>!agendaitem.agendaitemtype.name.match('Training'))
    let content;
    if (isLoading) {
        content =  <DefaultSpinner />;
    } else {
        content = agendaitems.map(item => (<ListGroup.Item key={item.id}><AgendaItem item={item}/></ListGroup.Item>));
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

function agendaItems(queryKey) {
    let now = new Date();
    const nextMonth  = new Date(now.getFullYear(), now.getMonth() + 1);
    let params = {year: nextMonth.getFullYear(), month: nextMonth.getMonth()}
    return Promise.all([getAgendaitems(queryKey), getAgendaitems(queryKey,params)])
        .then(([agendaItems1, agendaItems2]) => {
        return agendaItems1.concat(agendaItems2).filter(agendaItem => {
            const agendaDate = new Date(agendaItem.date);
            return agendaDate >= now;
        }).sort(sortAgendaItems);
    });
}


export default AgendaItemsSideBar;