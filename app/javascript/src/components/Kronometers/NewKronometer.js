import React from 'react'
import { useQueryCache } from 'react-query'
import { useHistory } from 'react-router-dom'
import NewObjectComponent from '../Generic/NewObjectComponent'
import { createKronometer } from './queries'
import { NewKronometerForm } from './KronometerForm'

const NewKronometer = (props) => {
  const parentId = props.match.params.parentid &&
    parseInt(props.match.params.parentid);
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
      FormComponent={NewKronometerForm.bind(this, parentId)}
    />
  )
}

export default NewKronometer
