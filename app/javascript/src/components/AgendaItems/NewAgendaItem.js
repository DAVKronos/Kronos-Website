import React, {useState} from 'react';
import {Form, Button} from 'react-bootstrap';
import {createAgendaitem} from "./queries";
import { useQueryCache} from "react-query";
import {Redirect, useHistory} from "react-router-dom";
import DefaultSpinner from "../Spinner";
import AgendaItemForm from "./AgendaItemForm";

const NewAgendaItem = () => {
    const queryCache = useQueryCache();
    const history = useHistory();

    const [values, setValues] = useState({});
    const setValue = (fieldName, value) => {
        let newValues = {...values, [fieldName]: value}
        setValues(newValues)
    }
    const [creating, setCreating] = useState(false);

    const cancel = () => {
        history.goBack();
    }

    const create = () => {
        setCreating(true);
        createAgendaitem({...values}).then(result => {
            setCreating(false);
            queryCache.setQueryData(['agendaitems', result.id], result)
            history.push(`/agendaitems/${result.id}`)
        }).catch(() => {
            setCreating(false);
        })
    }

    return (<React.Fragment>
    <h1>New Agendaitem</h1>
    <Form>
        <AgendaItemForm values={values} setValue={setValue} />
        <Button onClick={() => create()}>
            {creating && <DefaultSpinner inline size={'sm'}/>}
            {!creating && 'Create'}
        </Button>
        <Button variant='secondary' onClick={() => cancel()}>Cancel</Button>
    </Form></React.Fragment>);
}

export default NewAgendaItem