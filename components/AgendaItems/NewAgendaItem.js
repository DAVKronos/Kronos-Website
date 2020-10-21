import React from 'react';
import {Form, Row, Col} from 'react-bootstrap';


const NewAgendaItem = () => {
    return (<>
    <h1>New Agendaitem</h1>
    <Form>
        <Form.Group as={Row} controlId="formPlaintextEmail">
            <Form.Label column sm="2">
                Nederlandse Naam
            </Form.Label>
            <Col sm="10">
                <Form.Control type='text' />
            </Col>
        </Form.Group>

        <Form.Group as={Row} controlId="formPlaintextPassword">
            <Form.Label column sm="2">
                Engelse Naam
            </Form.Label>
            <Col sm="10">
                <Form.Control type="text" />
            </Col>
        </Form.Group>
        <Form.Group as={Row} controlId="formPlaintextPassword">
            <Form.Label column sm="2">
                Datum
            </Form.Label>
            <Col sm="10">
                <Form.Control type="date" />
            </Col>
        </Form.Group>
        <Form.Group as={Row} controlId="formPlaintextPassword">
            <Form.Label column sm="2">
                Engelse Naam
            </Form.Label>
            <Col sm="10">
                <Form.Control type="text" />
            </Col>
        </Form.Group>
        <Form.Group as={Row} controlId="formPlaintextPassword">
            <Form.Label column sm="2">
                Engelse Naam
            </Form.Label>
            <Col sm="10">
                <Form.Control type="text" />
            </Col>
        </Form.Group>
        <Form.Group as={Row} controlId="formPlaintextPassword">
            <Form.Label column sm="2">
                Engelse Naam
            </Form.Label>
            <Col sm="10">
                <Form.Control type="text" />
            </Col>
        </Form.Group>
    </Form></>);
}

export default NewAgendaItem