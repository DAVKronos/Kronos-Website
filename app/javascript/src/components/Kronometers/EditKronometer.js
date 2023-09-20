import React from 'react'
import { useQuery, useQueryCache } from 'react-query'
import DefaultSpinner from '../Generic/Spinner'
import { useHistory } from 'react-router-dom'
import EditObjectComponent from '../Generic/EditObjectComponent'
import { getKronometerById, updateKronometer } from './queries'
import { EditKronometerForm } from './KronometerForm'

const EditKronometerWithData = (props) => {
  const id = parseInt(props.match.params.id)
  const { isLoading, isError, data, error } = useQuery(['kronometers', id], getKronometerById)
  if (isLoading) {
    return <DefaultSpinner />
  }
  return data && <EditKronometer kronometer={data} />
}

const EditKronometer = ({ kronometer }) => {
  const queryCache = useQueryCache()
  const history = useHistory()
  const { id, name, folder_id, date } = kronometer
  const isPublic = kronometer.public
  const editableFields = { name, folder_id, date, public: isPublic }
  const onSuccess = (savedKronometer) => {
    queryCache.setQueryData(['kronometers', savedKronometer.id], savedKronometer)
    if (savedKronometer.folder_id) {
      history.push(`/kronometers/${savedKronometer.folder_id}`)
    } else {
      history.push('/kronometers')
    }
  }

  return (
    <EditObjectComponent
      id={id}
      existingObject={editableFields}
      objectName='kronometer'
      updateFunction={updateKronometer}
      onSuccess={onSuccess}
      FormComponent={EditKronometerForm}
    />
  )
}

export default EditKronometerWithData
