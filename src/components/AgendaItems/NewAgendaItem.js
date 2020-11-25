import React, {useState} from 'react';
import {Form, Button} from 'react-bootstrap';
import {createAgendaitem} from "./queries";
import { useQueryCache} from "react-query";
import {Redirect, useHistory} from "react-router-dom";
import DefaultSpinner from "../Spinner";
import AgendaItemForm from "./AgendaItemForm";
import {useTranslation} from "react-i18next";

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

    const {t} = useTranslation('generic');

    return (<React.Fragment>
    <h1>{t('new')} Agendaitem</h1>
    <Form>
        <AgendaItemForm values={values} setValue={setValue} />
        <Button onClick={() => create()}>
            {creating && <DefaultSpinner inline size={'sm'}/>}
            {!creating && t('create')}
        </Button>
        <Button variant='secondary' onClick={() => cancel()}>{t('cancel')}</Button>
    </Form></React.Fragment>);
}

export default NewAgendaItem