import React from 'react'
import FormField from '../Generic/FormField'
import { Form } from 'react-bootstrap'
import { getUserTypes } from './queries'
import { ability } from '../../utils/auth-helper'

const userFields = [
  {
    name: 'email',
    type: 'text',
    required: true
  },

  {
    name: 'phonenumber',
    type: 'text',
    required: true
  },
  {
    name: 'address',
    type: 'text',
    required: true
  },
  {
    name: 'postalcode',
    type: 'text',
    required: true
  },
  {
    name: 'city',
    type: 'text',
    required: true
  },
  {
    name: 'studie',
    type: 'text',
    required: true
  },
  {
    name: 'instelling',
    type: 'text',
    required: true
  },
  {
    name: 'aanvang',
    type: 'text'
  },

  {
    name: 'papieren_kronometer',
    type: 'boolean',
    required: true
  },
  {
    name: 'avatar',
    type: 'file'
  }
]

const adminUserFields = [
  {
    name: 'name',
    type: 'text',
    required: true
  },
  {
    name: 'initials',
    type: 'text',
    required: true
  },
  {
    name: 'birthdate',
    type: 'date',
    required: true
  },
  {
    name: 'user_type_id',
    type: 'reference',
    itemQuery: [['user_types'], getUserTypes]
  },
  ...userFields, // Add normal user fields
  {
    name: 'sex',
    type: 'text',
    required: true,
    options: ['Male', 'Female', 'Other']
  },
  {
    name: 'licensenumber',
    type: 'text',
    required: true
  },
  {
    name: 'xtracard',
    type: 'text',
    required: true
  },
  {
    name: 'bank_account_number',
    type: 'text',
    required: true
  }, {
    name: 'iban',
    type: 'text',
    required: true
  }
]

// TODO: make required do something (with react-hook-form)
const UserForm = ({ values, setValue, children }) => {
  const fields = ability.can('manage', 'User') ? adminUserFields : userFields

  return (
    <Form>
      {fields.map(
        ({ name, type, required, itemQuery, ...otherProps }) => {
          return (
            <FormField
              {...otherProps}
              key={name}
              modelName='user'
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

export default UserForm
export { userFields, adminUserFields }
