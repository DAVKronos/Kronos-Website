import React, {useState} from 'react';
import {Col, Form, Row} from "react-bootstrap";
import {useTranslation} from "react-i18next";
import DatePicker, {registerLocale} from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";
import nl from "date-fns/locale/nl";
import en from "date-fns/locale/en-GB";
import DefaultSpinner from './Spinner';
import Select from 'react-select'

import {useQuery} from "react-query";

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

const ReferenceControl = ({value, setValue, required, itemQuery, multiple, ...props}) => {
    const {isLoading, data = []}= useQuery(...itemQuery);
    const options = data.map(item => ({label: item.name, value: item.id}));
    
    let  selectValue;
    if (multiple) {
        selectValue = value ? value.map(v => options.find(option => option.value == v)) : null;
    } else {
        selectValue = value ? options.find(option => option.value == value) : null;
    }
    
    let onChange = newValue => {
        let transformedValue;
        if (multiple){
            transformedValue = newValue.map(v => v.value);
        } else {
            transformedValue = newValue ? newValue.value : null;
        }
        setValue(transformedValue)
    }

    return <Select  options={options}
                    value={selectValue} 
                    onChange={onChange} 
                        isLoading={isLoading}
                        isDisabled={isLoading}
                        isMulti={multiple} 
                        isClearable={!required}/>
}


const FieldControl = ({type, value, setValue, required, itemQuery, ...props}) => {
    if (type === 'reference') {
        const allProps = {type, value, setValue, required, itemQuery, ...props};
        return <ReferenceControl {...allProps} />
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