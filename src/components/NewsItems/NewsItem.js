import React from "react";
import {Button, Col, Row} from 'react-bootstrap';
import {getAPIHostUrl} from "../../utils/rest-helper";
import {format} from '../../utils/date-format';
import {useQuery} from "react-query";
import {getNewsItem, removeNewsItem} from "./queries";
import DefaultSpinner from "../Generic/Spinner";
import {Can} from "../../utils/auth-helper";
import {useTranslation} from "react-i18next";
import {Link, useHistory} from "react-router-dom";
import ReactMarkdown from 'react-markdown';


function NewsItem(props) {
    const {t, i18n} = useTranslation('generic');
    const history = useHistory();
    const id = props.match.params.id;
    const { isLoading, isError, data, error } = useQuery(['newsitems',id], getNewsItem);

    if (isLoading) {
        return <DefaultSpinner/>;
    }

    let item = data;
    if (!data) {
        return null;
    }

    const onClickRemove = () => {
        removeNewsItem(id).then(() => {
            history.back();
        });
    }
    const title = i18n.language === 'nl' ? item.title : item.title_en;
    const news = i18n.language === 'nl' ? item.news : item.news_en;

    return  <React.Fragment>
        <Row>
            <Col md={{span: 8, offset: 2}}>
                <h1>{title}</h1>
                <p>{format(item.created_at, 'PPP p', i18n.language)} | {item.user.name}</p>
            </Col>
        </Row>
        <Row>
            <Col md={{span: 8, offset: 2}}>
                <img src={getAPIHostUrl(item.articlephoto_url_carrousel)} alt={item.title}/>
                <ReactMarkdown source={news}/>
            </Col>
            <Col md={2}>
                <Can I="update" a={"Newsitem"}>
                    <Button variant='warning' as={Link} to={`/newsitems/${id}/edit`}>{t('edit')}</Button>
                </Can>
                <Can I="delete" a={"Newsitem"}>
                    <Button variant='danger' onClick={onClickRemove}>{t('remove')}</Button>
                </Can>
            </Col>
        </Row>
    </React.Fragment>
}

export default NewsItem;