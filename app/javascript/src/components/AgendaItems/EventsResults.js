import React from 'react';
import DefaultSpinner from "../Generic/Spinner";
import {Table} from 'react-bootstrap';
import {useQuery} from "react-query";
import {useTranslation} from "react-i18next";
import {getAgendaitemEvents} from "./queries";

const EventResults = ({event}) => {
    return <Table striped size='sm' key={event.id}>
        <thead>
        <tr>
            <th colSpan={3}>
                {event.name}
            </th>
        </tr>
        </thead>
        <tbody>
        {event.results && event.results.sort((a,b) => a.place - b.place).map(result => {
            return <tr key={result.id} className="d-flex">
                <td className="col-4">{result.result} {event.measuringUnit} {result.place && `(${result.place})`}</td>
                <td className="col-4">{result.username}</td>
                <td className="col-4">{Math.round(result.calculated * 100) / 100} {event.calculatedUnit}</td>
            </tr>
        })}
        </tbody>
    </Table>
}


const EventsResults = ({agendaItemId}) => {
    const { isLoading, isError, data, error } = useQuery(['agendaitemevents', agendaItemId], getAgendaitemEvents)
    const events = data;
    const {t} = useTranslation('generic');
    if (isLoading) {
        return <DefaultSpinner/>;
    }
    if (events.length>0) {
        return <React.Fragment>
            <h2>{t('models:modelNames.result_plural')}</h2>
            <div>
                {events && events.map(event => <EventResults key={event.id} event={event}/>)}
            </div>
        </React.Fragment>
    }
    return null;
};


export default EventsResults
export {EventResults}