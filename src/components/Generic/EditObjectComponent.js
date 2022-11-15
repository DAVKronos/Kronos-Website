import React, { useState } from 'react'
import { Alert, Button } from 'react-bootstrap'
import { useHistory } from 'react-router-dom'
import DefaultSpinner from '../Generic/Spinner'
import { useTranslation } from 'react-i18next'

const EditObjectComponent = ({ objectName, id, existingObject, updateFunction, FormComponent, onSuccess }) => {
  const history = useHistory()
  const [values, setValues] = useState({ ...existingObject })
  const setValue = (fieldName, value) => {
    const newValues = { ...values, [fieldName]: value }
    setValues(newValues)
  }
  const [saving, setSaved] = useState(false)

  const [message, setMessage] = useState('')

  const cancel = () => {
    history.goBack()
  }
  const update = () => {
    setSaved(true)
    updateFunction(id, { ...values }).then(result => {
      setSaved(false)
      setMessage('Agenda item updated!')
      onSuccess(result)
    }).catch(() => {
      setSaved(false)
    })
  }
  const { t } = useTranslation('generic')

  return (
    <>
      {message && <Alert variant='success' dismissible onClose={() => setMessage('')}>{message}</Alert>}
      <h1>{t('editModel', { model: t(`models:modelNames.${objectName}`, { count: 1 }) })}</h1>
      <FormComponent
        values={values}
        setValue={setValue}
      >
        <Button onClick={() => update()} disabled={saving}>
          {saving && <DefaultSpinner inline size='sm' />}
          {!saving && t('save')}
        </Button>
        <Button variant='secondary' onClick={() => cancel()}>{t('cancel')}</Button>
      </FormComponent>
    </>
  )
}

export default EditObjectComponent
