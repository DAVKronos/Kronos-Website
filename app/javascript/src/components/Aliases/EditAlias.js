import React from 'react'
import { useQuery, useQueryCache } from 'react-query'
import DefaultSpinner from '../Generic/Spinner'
import { useHistory } from 'react-router-dom'
import EditObjectComponent from '../Generic/EditObjectComponent'
import { getAlias, updateAlias } from './queries'
import AliasForm from './AliasForm'

const EditAliasWithData = (props) => {
  const id = parseInt(props.match.params.id)
  const { isLoading, isError, data, error } = useQuery(
    ['aliases', id],
    getAlias
  )
  if (isLoading) {
    return <DefaultSpinner />
  }
  return data && <EditAlias alias={data} />
}

const EditAlias = ({ alias }) => {
  const queryCache = useQueryCache()
  const history = useHistory()
  const { id, name, description, emailaddress } = alias
  const editableFields = { name, emailaddress, description }
  const onSuccess = (savedAlias) => {
    queryCache.setQueryData(['aliases', savedAlias.id], savedAlias)
    history.push('/admin/aliases/')
  }

  return (
    <EditObjectComponent
      id={id}
      existingObject={editableFields}
      objectName='alias'
      updateFunction={updateAlias}
      onSuccess={onSuccess}
      FormComponent={AliasForm}
    />
  )
}

export default EditAliasWithData
