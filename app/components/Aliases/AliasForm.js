import React from 'react'
import FormField from '../Generic/FormField'
import { Form } from 'react-bootstrap'

const aliasFields = [
  {
    name: 'name',
    type: 'text',
    required: true
  },
  {
    name: 'emailaddress',
    type: 'text',
    required: true
  },
  {
    name: 'description',
    type: 'text',
    required: true
  }
]

// TODO: make required do something (with react-hook-form)
const AliasForm = ({ values, setValue, children }) => {
  return (
    <Form>
      {aliasFields.map(({ name, type, required, ...otherProps }) => {
        return (
          <FormField
            {...otherProps}
            key={name}
            modelName='alias'
            fieldName={name}
            value={values[name]}
            setValue={(v) => setValue(name, v)}
            type={type}
            required={required}
          />
        )
      })}
      {children}
    </Form>
  )
}

export default AliasForm
