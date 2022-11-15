import React from 'react'
import FormField from '../Generic/FormField'
import { Form } from 'react-bootstrap'

const agendaItemFields = [{
  name: 'name',
  type: 'text',
  required: true
}]

// TODO: make required do something (with react-hook-form)
const AgendaItemTypeForm = ({ values, setValue, children }) => {
  return (
    <Form>
      <FormField
        modelName='agendaitem'
        fieldName='name'
        value={values.name}
        setValue={(v) => setValue('name', v)}
        type='text'
        required
      />
      {children}
    </Form>
  )
}

export default AgendaItemTypeForm
