import React from 'react'
import { useQueryCache } from 'react-query'
import { useHistory } from 'react-router-dom'
import NewObjectComponent from '../Generic/NewObjectComponent'
import { createKronometer } from './queries'
import KronometerForm from './KronometerForm'

const NewFolder = () => {
  const queryCache = useQueryCache()
  const history = useHistory()

  const onSuccess = (savedKronometer) => {
    queryCache.setQueryData(['kronometers', savedKronometer.id], savedKronometer)
    queryCache.invalidateQueries('kronometers')
    if (savedKronometer.folder_id) {
      history.push(`/kronometers/${savedKronometer.folder_id}`)
    } else {
      history.push('/kronometers')
    }
  }

  return (
    <NewObjectComponent
      objectName='kronometer'
      createFunction={createKronometer}
      onSuccess={onSuccess}
      FormComponent={KronometerForm}
    />
  )
}

export default NewFolder
