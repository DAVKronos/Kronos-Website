import React from 'react'
import { useQueryCache } from 'react-query'
import { useHistory } from 'react-router-dom'
import NewObjectComponent from '../Generic/NewObjectComponent'
import { createCommission } from './queries'
import CommissionForm from './CommissionForm'

const NewCommission = () => {
  const queryCache = useQueryCache()
  const history = useHistory()

  const onSuccess = (savedCommission) => {
    queryCache.setQueryData(['commissions', savedCommission.id], savedCommission)
    queryCache.invalidateQueries('commissions')
    history.push('/commissions')
  }

  return (
    <NewObjectComponent
      objectName='commission'
      createFunction={createCommission}
      onSuccess={onSuccess}
      FormComponent={CommissionForm}
    />
  )
}

export default NewCommission
