import React from 'react'
import { ListGroup, Row, Col } from 'react-bootstrap';
import { NavLink} from "react-router-dom";

const AdminHome = () => {
    return <Row style={{marginTop: 20}}>
        <Col md={6}>
        <ListGroup>
        <ListGroup.Item as={NavLink} to={'/admin/approve-news'} action>Nieuwsitems goedkeuren</ListGroup.Item>
        <ListGroup.Item as={NavLink} to={'/admin/mailinglists'} action>Mailinglijsten beheren</ListGroup.Item>
        <ListGroup.Item as={NavLink} to={'/admin/pages'} action>Informatie pagina's beheren</ListGroup.Item>
        <ListGroup.Item action>Generiek objecten beheren</ListGroup.Item>
    </ListGroup>
    </Col>
    </Row>
}

export default AdminHome