import React from "react";
import FormField from "../Generic/FormField";
import {Form} from "react-bootstrap";


const photoAlbumFields = [{
    name: 'name',
    type: 'text',
    required: true
}, {
    name: "name_en",
    type: 'text',
    required: true
}, {
    name: "public",
    type: 'boolean',
    required: true
}, {
    name: "date",
    type: 'date',
    required: true
}, {
    name: "external_url",
    type: 'text'
}]

// TODO: make required do something (with react-hook-form)
const PhotoAlbumForm = ({values, setValue, children }) => {
    return <Form>
        {photoAlbumFields.map((field) => {
            return <FormField
                key={field.name}
                modelName={'photoalbum'}
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


export default PhotoAlbumForm