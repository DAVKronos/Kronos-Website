import React from "react";
import { Link } from 'react-router-dom';
import {Row, Col, Image} from 'react-bootstrap';
import {getAPIHostUrl} from "../../utils/rest-helper";
import {format} from '../../utils/date-format.js'
import {useTranslation} from "react-i18next";

const ShortNewsItem = ({item}) => {
    const { t } = useTranslation('homepage');
    return <Row>
        <Col md={3} style={{display: 'flex'}}>
            <Link to={`/newsitems/${item.id}`} className="align-self-center">
                <Image className="d-block w-100" src={getAPIHostUrl(item.articlephoto_url_normal)} alt={item.title} thumbnail/>
            </Link>
        </Col>
        <Col md={9}>
            <header>
                <Link to={`/newsitems/${item.id}`}><h2>{item.title}</h2></Link>
                <p>{format(item.created_at, 'PPP p')} | {item.user.name}</p>
            </header>
            <p>{item.news.split('\n')[0]}</p>
            <Link to={`/newsitems/${item.id}`}>{t('readMore')}</Link>
        </Col>
    </Row>
};

export default ShortNewsItem;