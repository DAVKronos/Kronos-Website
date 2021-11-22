import React, {useState} from 'react';
import ContactForm from "./ContactForm";
import {Row, Col, Button, Alert} from 'react-bootstrap';
import {useTranslation} from "react-i18next";
import DefaultSpinner from "../Generic/Spinner";
import {createContactMessage} from "./queries";

const Contact = () => {
    const {t} = useTranslation(['contactPage', 'generic']);
    const [values, setValues] = useState({});
    const setValue = (fieldName, value) => {
        let newValues = {...values, [fieldName]: value};
        setValues(newValues);
    }

    const [creating, setCreating] = useState(false);
    const [error, setError] = useState(null);

    const create = () => {
        setCreating(true);
        createContactMessage({...values}).then(result => {
            setCreating(false);

        }).catch((error) => {
            setCreating(false);
            if (error.response.status === 400){
                setError('Sommige velden missen');
            }

        })
    }

    return <Row>
        <Col md={8} sm={12}>
            <h1>{t('contactPage:title')}</h1>
            {error && <Alert variant='danger'>{<p>{error}</p>}</Alert>}
            <ContactForm  values={values} setValue={setValue} />
            <Button onClick={() => create()}>
                {creating && <DefaultSpinner inline size={'sm'}/>}
                {!creating && t('generic:send')}
            </Button>
        </Col>
    </Row>;
};

export default Contact;