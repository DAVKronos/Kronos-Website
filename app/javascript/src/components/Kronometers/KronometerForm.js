import React from 'react'
import FormField from '../Generic/FormField'
import { Form } from 'react-bootstrap'
import { getFolders, getFoldersWithoutId } from './queries'

// TODO: make required do something (with react-hook-form)
const NewKronometerForm = (parentId, { values, setValue, children }) => {
  const kronometerFields = [{ name: 'name', type: 'text', required: true },
  { name: 'date', type: 'date', required: true },
  { name: 'public', type: 'boolean', required: true },
  { name: 'file', type: 'file' }]

  if (parentId) {
    values['folder_id'] = parentId
  }

  return (
    <Form>
      {kronometerFields.map(
        ({ name, type, required, ...otherProps }) => {
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
            />
          )
        }
      )}
      {children}
    </Form>
  )
}

const EditKronometerForm = ({ values, setValue, children }) => {
  const kronometerFields = [{ name: 'name', type: 'text', required: true },
  { name: 'date', type: 'date', required: true },
  { name: 'public', type: 'boolean', required: true },
  { name: 'file', type: 'file' },
  { name: 'folder_id', type: 'reference', itemQuery: [['folders'], () => getFoldersWithoutId('folders', -1)] }]

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

export {
  NewKronometerForm,
  EditKronometerForm
}