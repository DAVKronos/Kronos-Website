import React from "react";
import { Link } from 'react-router-dom';
import {Row, Col, Image} from 'react-bootstrap';
import {getAPIHostUrl} from "../../utils/rest-helper";
import {format} from '../../utils/date-format.js'
import {useTranslation} from "react-i18next";
import ReactMarkdown from "react-markdown";
import {BsFillChatTextFill} from 'react-icons/bs';
import MultiLanguageText from "../Generic/MultiLanguageText";

const ShortNewsItem = ({item}) => {
    const { t, i18n } = useTranslation('homepage');
    const renderNews = (news) => {
        return <ReactMarkdown source={news.split('\n')[0]}/>;
    }
    let commentCount = null;
    if (item.comment_count) {
        commentCount = <React.Fragment> | <BsFillChatTextFill/> {item.comment_count}</React.Fragment>
    }

    return <Row>
        <Col md={3} style={{display: 'flex'}}>
            <Link to={`/newsitems/${item.id}`} className="align-self-center">
                <Image className="d-block w-100" src={getAPIHostUrl(item.articlephoto_url_normal)} alt={item.title} thumbnail/>
            </Link>
        </Col>
        <Col md={9}>
            <header>
                <Link to={`/newsitems/${item.id}`}><h2><MultiLanguageText nl={item.title} en={item.title_en}/></h2></Link>
                <p>{format(item.created_at, 'PPP p', i18n.language)} | {item.user.name}{commentCount}</p>
            </header>
            <MultiLanguageText nl={item.news} en={item.news_en} renderFunction={renderNews}/>
            <Link to={`/newsitems/${item.id}`}>{t('readMore')}</Link>
        </Col>
    </Row>
};

export default ShortNewsItem;