import React from 'react'
import FormField from '../../Generic/FormField'
import { Form } from 'react-bootstrap'
import { getFoldersWithoutId } from '../queries'


// TODO: make required do something (with react-hook-form)
const NewFolderForm = (parentId, { values, setValue, children }) => {
  const folderFields = [{ name: 'name', type: 'text', required: true }]

  if (parentId) {
    values['folder_id'] = parentId
  }

  return (
    <Form>
      {folderFields.map(
        ({ name, type, required, ...otherProps }) => {
          return (
            <FormField
              {...otherProps}
              key={name}
              modelName='folder'
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


const EditFolderForm = (folderId, { values, setValue, children }) => {
  const folderFields =
    [{
      name: 'name',
      type: 'text',
      required: true
    },
    {
      name: 'folder_id',
      type: 'reference',
      itemQuery: [['folders'], () => getFoldersWithoutId('folders', folderId)]
    }]

  return (
    <Form>
      {folderFields.map(
        ({ name, type, required, itemQuery, ...otherProps }) => {
          return (
            <FormField
              {...otherProps}
              key={name}
              modelName='folder'
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


export {
  NewFolderForm,
  EditFolderForm
}

