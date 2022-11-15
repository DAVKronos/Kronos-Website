import React from 'react'
import FormField from '../Generic/FormField'
import { Form } from 'react-bootstrap'
import { getUsers } from '../Users/queries'

const commissionFields = [
  {
    name: 'name',
    type: 'text',
    required: true
  },
  {
    name: 'name_en',
    type: 'text',
    required: true
  },
  {
    name: 'description',
    type: 'textarea',
    required: true
  }, {
    name: 'description_en',
    type: 'textarea',
    required: true
  }
]

// TODO: make required do something (with react-hook-form)
const CommissionForm = ({ values, setValue, children }) => {
  return (
    <Form>
      {commissionFields.map(
        ({ name, type, required, itemQuery, ...otherProps }) => {
          return (
            <FormField
              {...otherProps}
              key={name}
              modelName='commission'
              fieldName={name}
              value={values[name]}
              setValue={(v) => setValue(name, v)}
              type={type}
              required={required}
              itemQuery={itemQuery}
            />
          )
        }
      )}
      {children}
    </Form>
  )
}

export default CommissionForm
