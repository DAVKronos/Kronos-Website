import React from 'react'
import {Row, Col} from 'react-bootstrap';
import NewsItems from "./HomePageNewsItems";
import AgendaItemsSidebar from "./AgendaItemsSidebar";
import StravaSidebar from "./StravaSidebar";
import UserBirthdays from "./UserBirthdays";
import {useTranslation} from "react-i18next";
import {Can} from "../../utils/auth-helper";
import Announcement from './Announcement';

let HomePage = () => {
    const { t } = useTranslation('homepage');
    return (
    <React.Fragment>
    <Row>
        <Col md={12}>
            <Announcement/>
        </Col>
        <Col><h1>{t('news')}</h1></Col>
    </Row>
    <Row>
        <Col md={8}>
            <NewsItems /></Col>
        <Col md={4}>
            <AgendaItemsSidebar />
            <StravaSidebar />
            <Can I='read' a="User">
                <UserBirthdays />
            </Can>
        </Col>
    </Row></React.Fragment>);
};

export default HomePage;
