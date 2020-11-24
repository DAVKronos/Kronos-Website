import React from 'react';
import {Col, Form, Row} from "react-bootstrap";
import {useTranslation} from "react-i18next";
import DatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";

const FormField = ({modelName, fieldName, value, setValue, type, ...props}) => {
    return <Form.Group as={Row} controlId={fieldName}>
        <Form.Label column sm="2">
            <FieldLabel modelName={modelName} fieldName={fieldName} />
        </Form.Label>
        <Col sm="10">
            <FieldControl setValue={setValue} value={value} type={type} {...props} />
        </Col>
    </Form.Group>
}

const FieldLabel = ({modelName, fieldName}) => {
    const {t} = useTranslation('models');
    return t(`${modelName}.${fieldName}`)
}


const FieldControl = ({type, value, setValue, ...props}) => {
    if (type === 'reference') {
        const {items} = props;
        return <Form.Control as="select" value={value} onChange={e => setValue(e.target.value)}>
            {items && items.map(item => {
                return <option key={item.id} value={item.id}>{item.name}</option>
            })}
        </Form.Control>
    } else if (type === 'date' || type === 'datetime') {
        const {i18n} = useTranslation();
        if (!value) {
            value = new Date();
        } else if (!(value instanceof Date)) {
            value = new Date(value);
        }
        return <DatePicker selected={value}
                           locale={i18n.locale}
                           showTimeSelect={type === 'datetime'}
                           onChange={date => setValue(date)}
        />;
    } else if (type === 'boolean') {
        return <Form.Check type="checkbox" checked={value} onChange={() => setValue(!value)}/>
    } else if (type === 'textarea') {
        return <Form.Control as="textarea" value={value} onChange={(e) => setValue(e.target.value)}/>
    }
    return <Form.Control type='text' value={value} onChange={(e) => setValue(e.target.value)}/>
}


export default FormField