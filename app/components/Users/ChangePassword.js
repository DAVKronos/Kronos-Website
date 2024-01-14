import React, { useState } from 'react'
import { Row, Col, Form, Button, Alert } from 'react-bootstrap'
import { FieldControl } from '../Generic/FormField'
import DefaultSpinner from '../Generic/Spinner'
import { useTranslation } from 'react-i18next'
import { changePassword } from '../../utils/auth-helper'

const ChangePasswordPage = () => {
  const { t } = useTranslation('userpage')
  const [password, setPassword] = useState('')
  const [passwordConfirmation, setPasswordConfirmation] = useState('')
  const [changeSent, setChangeSent] = useState({
    loading: false,
    succesfull: false
  })
  const [message, setMessage] = useState(null)

  const onSubmit = () => {
    setChangeSent({ loading: true, succesfull: false })
    const passwordUnequal =
    password && passwordConfirmation && password != passwordConfirmation
    if (passwordUnequal) {
      setMessage({ variant: 'danger', message: t('unEqualPassword') })
      setChangeSent({ loading: false, succesfull: false })
    } else {
      setMessage(null)
      changePassword(password, passwordConfirmation).then(
        () => {
          setChangeSent({ loading: false, succesfull: true })
          setPassword('')
          setPasswordConfirmation('')
          setMessage({ variant: 'success', message: t('changePasswordSentMessage') })
        },
        (error) => {
          setChangeSent({ loading: false, succesfull: false })
          setPassword('')
          setPasswordConfirmation('')
          if (error.response.data && error.response.data.errors && error.response.data.errors.full_messages) {
            setMessage({ variant: 'danger', message: error.response.data.errors.full_messages.join(', ') })
          }
        }
      )
    }
  }

  return (
    <>
      <Row>
        <Col>
          <h1>{t('changePassword')}</h1>
        </Col>
      </Row>
      <Row>
        <Col md={6}>
          {changeSent.loading && <DefaultSpinner />}
          {message && (
            <Alert variant={message.variant}>{message.message}</Alert>
          )}

          {!changeSent.loading && !changeSent.succesfull && (
            <Form>
              <Form.Group>
                <FieldControl
                  type='password'
                  placeholder='Password'
                  value={password}
                  setValue={setPassword}
                />
              </Form.Group>
              <Form.Group>
                <FieldControl
                  type='password'
                  placeholder='Password confirmation'
                  value={passwordConfirmation}
                  setValue={setPasswordConfirmation}
                />
              </Form.Group>

              <Button onClick={() => onSubmit()}>
                {t('changePassword')}
              </Button>
            </Form>
          )}
        </Col>
      </Row>
    </>
  )
}

export default ChangePasswordPage
