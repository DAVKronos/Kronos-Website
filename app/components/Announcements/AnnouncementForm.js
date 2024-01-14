import React from 'react'
import FormField from '../Generic/FormField'
import { Form } from 'react-bootstrap'

const pageFields = [{
  name: 'title',
  type: 'text',
  required: true
}, {
  name: 'message',
  type: 'text',
  required: true
},
{
  name: 'background',
  type: 'file'
},
{
  name: 'url',
  type: 'text'
}, {
  name: 'starts_at',
  type: 'date'
},
{
  name: 'ends_at',
  type: 'date'
}]

// TODO: make required do something (with react-hook-form)
const AnnouncementForm = ({ values, setValue, children }) => {
  return (
    <Form>
      {pageFields.map((field) => {
        return (
          <FormField
            key={field.name}
            modelName='announcement'
            fieldName={field.name}
            value={values[field.name]}
            setValue={(v) => setValue(field.name, v)}
            type={field.type}
            required={field.required}
          />
        )
      })}
      {children}
    </Form>
  )
}

export default AnnouncementForm
