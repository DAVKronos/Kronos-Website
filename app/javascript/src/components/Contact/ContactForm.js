import React, { useContext } from 'react'
import { Form } from 'react-bootstrap'
import FormField from '../Generic/FormField'
import ReCAPTCHA from 'react-google-recaptcha'
import { EnvContext } from '../../App'

const ContactForm = ({ values, setValue }) => {
  const { RECAPTCHA_SITE_KEY } = useContext(EnvContext)

  return (
    <Form className='form-padding'>

      <FormField
        fieldName='name'
        modelName='contact'
        value={values.name}
        setValue={(v) => setValue('name', v)}
        type='text'
      />
      <FormField
        fieldName='email'
        modelName='contact'
        value={values.email}
        setValue={(v) => setValue('email', v)}
        type='text'
      />
      <FormField
        fieldName='message'
        modelName='contact'
        value={values.message}
        setValue={(v) => setValue('message', v)}
        type='textarea'
      />
      <ReCAPTCHA
        sitekey={RECAPTCHA_SITE_KEY}
        onChange={(v) => setValue('g-recaptcha', v)}
      />
    </Form>
  )
}

export default ContactForm
