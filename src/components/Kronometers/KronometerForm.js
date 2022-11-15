import React from 'react'
import FormField from '../Generic/FormField'
import { Form } from 'react-bootstrap'
import { getFolders } from './queries'

const kronometerFields = [
  {
    name: 'name',
    type: 'text',
    required: true
  },
  {
    name: 'date',
    type: 'date',
    required: true
  },
  {
    name: 'public',
    type: 'boolean',
    required: true
  },
  {
    name: 'folder_id',
    type: 'reference',
    itemQuery: [['folders'], getFolders]
  },
  {
    name: 'file',
    type: 'file'
  }
]

// TODO: make required do something (with react-hook-form)
const KronometerForm = ({ values, setValue, children }) => {
  return (
    <Form>
      {kronometerFields.map(
        ({ name, type, required, itemQuery, ...otherProps }) => {
          return (
            <FormField
              {...otherProps}
              key={name}
              modelName='kronometer'
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

export default KronometerForm
