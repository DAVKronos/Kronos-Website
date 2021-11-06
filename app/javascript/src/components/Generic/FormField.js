import React from 'react';
import {Col, Form, Row} from "react-bootstrap";
import {useTranslation} from "react-i18next";
import DatePicker, {registerLocale} from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";
import nl from "date-fns/locale/nl";
import en from "date-fns/locale/en-GB";

registerLocale('nl', nl)
registerLocale('en', en)

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


const FieldControl = ({type, value, setValue, required, ...props}) => {
    if (type === 'reference') {
        const {t} = useTranslation('generic');
        const {items, ...otherProps} = props;
        return <Form.Control as="select" value={value || ""} onChange={e => setValue(e.target.value)} {...otherProps}>
            <option value="" disabled={required}>{t('empty')}</option>
            {items && items.map(item => {
                return <option key={item.id} value={item.id}>{item.name}</option>
            })}
        </Form.Control>
    } else if (type === 'date' || type === 'datetime' || type === "time") {
        const {i18n} = useTranslation();
        if (!value) {
            value = new Date();
        } else if (!(value instanceof Date)) {
            value = new Date(value);
        }

        if (type==='datetime') {
            return <DatePicker selected={value}
                               locale={i18n.language}
                               showTimeSelect
                               dateFormat="Pp"
                               onChange={date => setValue(date)}
                               className="form-control form-control-sm"
                               show

            />;
        } else if (type==='time') {
            return <DatePicker selected={value}
                               locale={i18n.language}
                               showTimeSelect
                               showTimeSelectOnly
                               timeIntervals={5}
                               timeCaption="Time"
                               dateFormat="p"
                               className="form-control form-control-sm"
                               onChange={date => setValue(date)}
                               show
                               {...props}
            />;
        }


        return <DatePicker selected={value}
                           locale={i18n.locale}
                           className="form-control form-control-sm"
                           onChange={date => setValue(date)}/>
    } else if (type === 'boolean') {
        return <Form.Check type="checkbox" checked={value} onChange={() => setValue(!value)} {...props}/>
    } else if (type === 'text') {
        return <Form.Control type="text" value={value || ""} onChange={(e) => setValue(e.target.value)} {...props}/>
    } else if (type === 'textarea') {
        return <Form.Control as="textarea" value={value || ""} onChange={(e) => setValue(e.target.value)} {...props}/>
    } else if (type === 'number') {
        return <Form.Control type="number" value={value || ""} onChange={(e) => setValue(e.target.value)} {...props}/>
    }  else if (type === 'file') {
        const handleFileUpload = (e) => {
            setValue(e.target.files[0]);
        }
        return <Form.File onChange={handleFileUpload} {...props}/>
    }
    return <Form.Control type='text' value={value} onChange={(e) => setValue(e.target.value)} {...props}/>
}


export default FormField
export {FieldControl}