import React, {useState} from 'react';
import {Button, Alert} from 'react-bootstrap';
import {useHistory} from "react-router-dom";
import DefaultSpinner from "../Generic/Spinner";
import {useTranslation} from "react-i18next";

const NewObjectComponent = ({FormComponent, createFunction, onSuccess, objectName}) => {
    const history = useHistory();

    const [values, setValues] = useState({});
    const setValue = (fieldName, value) => {
        let newValues = {...values, [fieldName]: value}
        setValues(newValues)
    }
    const [creating, setCreating] = useState(false);
    const [error, setError] = useState(null);

    const cancel = () => {
        history.goBack();
    }

    const create = () => {
        setCreating(true);
        createFunction({...values}).then(result => {
            setCreating(false);
            onSuccess(result);
        }).catch((error) => {
            setCreating(false);
            if (error.response.status === 400){
                setError('Sommige velden missen');
            }

        })
    }

    const {t} = useTranslation('generic');

    return (<React.Fragment>
        <h1>{t('addModel', {model: t(`models:modelNames.${objectName}`)})}</h1>
        {error && <Alert variant='danger'>{<p>{error}</p>}</Alert>}
        <FormComponent values={values} setValue={setValue} />
        <Button onClick={() => create()}>
            {creating && <DefaultSpinner inline size={'sm'}/>}
            {!creating && t('create')}
        </Button>
        <Button variant='secondary' onClick={() => cancel()}>{t('cancel')}</Button>
    </React.Fragment>);
}

export default NewObjectComponent