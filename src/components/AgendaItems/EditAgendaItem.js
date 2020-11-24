import React, {useState} from 'react';
import {Alert, Button} from 'react-bootstrap';
import {updateAgendaitem, getAgendaitem} from "./queries";
import {useQuery, useQueryCache} from "react-query";
import {useHistory} from "react-router-dom";
import DefaultSpinner from "../Spinner";
import AgendaItemForm from "./AgendaItemForm";

const EditAgendaItemWithData = (props) => {
    const id = props.match.params.id;
    const { isLoading, isError, data, error } = useQuery(['agendaitems', id], getAgendaitem)
    if (isLoading) {
        return <DefaultSpinner />;
    }
    return data &&<EditAgendaItem agendaItem={data} />
}

const EditAgendaItem = ({agendaItem}) => {

    const queryCache = useQueryCache()
    const history = useHistory()
    const {id, created_at, updated_at, category, user_id, ...visibleFields} = agendaItem;
    const [values, setValues] = useState({...visibleFields});
    const setValue = (fieldName, value) => {
        let newValues = {...values, [fieldName]: value}
        setValues(newValues)
    }
    const [saving, setSaved] = useState(false);

    const [message, setMessage] = useState('')

    const cancel = () => {
        history.goBack();
    }
    const update = () => {
        setSaved(true);
        updateAgendaitem(agendaItem.id,{...values}).then(result => {
            setSaved(false);
            setMessage('Agenda item updated!')
            queryCache.setQueryData(['agendaitems', result.id], result)
            history.push(`/agendaitems/${result.id}`)
        }).catch(() => {
            setSaved(false);
        })
    }


    return (<React.Fragment>
        {message && <Alert variant='success' dismissible onClose={() => setMessage('')}>{message}</Alert>}
        <h1>Edit Agendaitem</h1>
            <AgendaItemForm values={values}
                            setValue={setValue}>
                <Button onClick={() => update()} disabled={saving}>
                    {saving && <DefaultSpinner inline size={'sm'}/>}
                    {!saving && 'Save'}
                </Button>
                <Button variant='secondary' onClick={() => cancel()}>Cancel</Button>
            </AgendaItemForm>
        </React.Fragment>);
}

export default EditAgendaItemWithData