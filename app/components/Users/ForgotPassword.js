import React, { useState } from 'react'
import { Row, Col, Form, Button } from 'react-bootstrap'
import { forgotPassword } from '../../utils/auth-helper'
import { FieldControl } from '../Generic/FormField'
import DefaultSpinner from '../Generic/Spinner'
import { useTranslation } from 'react-i18next'

const ForgotPasswordPage = () => {
  const { t } = useTranslation('loginMenu')
  const [email, setEmail] = useState(null)
  const [resetSent, setResetSent] = useState({ loading: false, succesfull: false })

  const onSubmit = () => {
    setResetSent({ loading: true, succesfull: false })
    forgotPassword(email).then(() => {
      setResetSent({ loading: false, succesfull: true })
    }, () => {
      setResetSent({ loading: false, succesfull: false })
    })
  }

  return (
    <>
      <Row>
        <Col>
          <h1>{t('forgotPassword')}</h1>
        </Col>
      </Row>
      <Row>
        <Col md={6}>
          {resetSent.loading && <DefaultSpinner />}
          {!resetSent.loading && !resetSent.succesfull &&
            <Form>
              <Form.Group><FieldControl
                type='text'
                placeholder='Email'
                value={email}
                setValue={setEmail}
                          />
              </Form.Group>

              <Button onClick={() => onSubmit()}>{t('resetPassword')}</Button>
            </Form>}
          {!resetSent.loading && resetSent.succesfull && <p>
            {t('resetPasswordSentMessage')}

                                                         </p>}
        </Col>
      </Row>
    </>
  )
}

export default ForgotPasswordPage
