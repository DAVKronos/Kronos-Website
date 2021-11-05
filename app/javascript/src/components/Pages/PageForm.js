import React from "react";
import FormField from "../Generic/FormField";
import {Form} from "react-bootstrap";


const pageFields = [{
    name: 'pagetag',
    type: 'text',
    required: true
}, {
    name: "pagetag_en",
    type: 'text',
    required: true
}, 
{
    name: "highlight",
    type: 'boolean'
},
{
    name: "public",
    type: 'boolean'
},{
    name: "menu",
    type: 'text'
},
{
    name: "sort_order",
    type: 'number'
},
{
    name: "information",
    type: 'textarea',
    required: true
}, {
    name: "information_en",
    type: 'textarea',
    required: true
}]

// TODO: make required do something (with react-hook-form)
const PageForm = ({values, setValue, children }) => {
    return <Form>
        {pageFields.map((field) => {
            return <FormField
                key={field.name}
                modelName={'page'}
                fieldName={field.name}
                value={values[field.name]}
                setValue={(v) => setValue(field.name, v)}
                type={field.type}
                required={field.required}
            />
        })}
        {children}
    </Form>
}


export default PageForm