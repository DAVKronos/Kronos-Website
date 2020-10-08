import React from 'react'
import {Row, Col} from 'react-bootstrap';
import NewsItems from "./HomePageNewsItems";
import AgendaItemsSidebar from "./AgendaItemsSidebar";
import StravaSidebar from "./StravaSidebar";

let HomePage = () => {
    return (
    <React.Fragment>
    <Row>
        <Col><h1>Nieuws</h1></Col>
    </Row>
    <Row>
        <Col md={8}>
            <NewsItems /></Col>
        <Col md={4}>
            <AgendaItemsSidebar />
            <StravaSidebar />
        </Col>
    </Row></React.Fragment>);
};

export default HomePage;
