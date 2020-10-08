import React from 'react';
import {Spinner} from 'react-bootstrap';

const DefaultSpinner = () => {
    return <div style={{margin: 10}}><Spinner animation="border" role="status">
        <span className="sr-only">Loading...</span>
    </Spinner></div>;
}

export default DefaultSpinner