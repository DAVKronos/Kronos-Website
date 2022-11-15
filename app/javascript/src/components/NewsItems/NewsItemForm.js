import React from 'react'
import FormField from '../Generic/FormField'
import { Form } from 'react-bootstrap'

const newsItemFields = [{
  name: 'title',
  type: 'text',
  required: true
}, {
  name: 'title_en',
  type: 'text',
  required: true
}, {

  name: 'news',
  type: 'textarea',
  required: true
}, {
  name: 'news_en',
  type: 'textarea',
  required: true
}, {
  name: 'articlephoto',
  type: 'file'
}]

// TODO: make required do something (with react-hook-form)
const NewsItemForm = ({ values, setValue, children }) => {
  return (
    <Form>
      {newsItemFields.map((field) => {
        return (
          <FormField
            key={field.name}
            modelName='newsitem'
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

export default NewsItemForm
