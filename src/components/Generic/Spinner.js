import React from 'react'
import { Spinner } from 'react-bootstrap'

const DefaultSpinner = ({ inline, size }) => {
  return (
    <div style={{ margin: !inline && 10 }}><Spinner animation='border' role='status' size={size}>
      <span className='sr-only'>Loading...</span>
    </Spinner>
    </div>
  )
}

export default DefaultSpinner
