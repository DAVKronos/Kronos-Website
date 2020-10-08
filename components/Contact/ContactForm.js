import React from 'react';
import {Button, Form} from 'react-bootstrap';

export default function ContactForm() {
    return <Form style={{padding: 7}}>
		<h3>Stuur ons een bericht</h3>
        <Form.Group controlId="FormBasicName">
			<Form.Label>Naam</Form.Label>
            <Form.Control type="text"/>
        </Form.Group>
        <Form.Group controlId="formBasicEmail">
			<Form.Label>E-mail</Form.Label>
            <Form.Control type="text"/>
        </Form.Group>
        <Form.Group controlId="formBasicMessage">
			<Form.Label>Bericht</Form.Label>
            <Form.Control type="text"/>
        </Form.Group>
        <Button variant="primary">
            Verstuur
        </Button>
    </Form>
}