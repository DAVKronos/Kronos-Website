import React from 'react'
import {Row, Col} from 'react-bootstrap';
import NewsItems from "./HomePageNewsItems";
import AgendaItemsSidebar from "./AgendaItemsSidebar";
import StravaSidebar from "./StravaSidebar";
import UserBirthdays from "./UserBirthdays";
import PrivateComponent from "../PrivateComponent";
import {useTranslation} from "react-i18next";

let HomePage = () => {
    const { t } = useTranslation('homepage');
    return (
    <React.Fragment>
    <Row>
        <Col><h1>{t('news')}</h1></Col>
    </Row>
    <Row>
        <Col md={8}>
            <NewsItems /></Col>
        <Col md={4}>
            <AgendaItemsSidebar />
            <StravaSidebar />
            <PrivateComponent>
                <UserBirthdays />
            </PrivateComponent>
        </Col>
    </Row></React.Fragment>);
};

export default HomePage;
