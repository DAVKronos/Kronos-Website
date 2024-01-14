import React from 'react'
import { useQueryCache } from 'react-query'
import { useHistory } from 'react-router-dom'
import NewObjectComponent from '../Generic/NewObjectComponent'
import { createUser } from './queries'
import UserForm from './UserForm'

const NewFolder = () => {
  const queryCache = useQueryCache()
  const history = useHistory()

  const onSuccess = (savedUser) => {
    queryCache.setQueryData(['users', savedUser.id], savedUser)
    queryCache.invalidateQueries('users')
    history.push(`/users/${savedUser.id}`)
  }

  return (
    <NewObjectComponent
      objectName='user'
      createFunction={createUser}
      onSuccess={onSuccess}
      FormComponent={UserForm}
    />
  )
}

export default NewFolder
