import React from 'react'
import {Link} from "react-router-dom";
import {Row, Col, Image, Button} from 'react-bootstrap';
import {useTranslation} from "react-i18next";
import {useQuery,useQueryCache} from "react-query";
import Paginate from "../Generic/Paginate";
import DefaultSpinner from "../Generic/Spinner";
import {getNewsItems} from "./queries";
import {Can} from "../../utils/auth-helper";
import {subject} from "@casl/ability";
import {removeNewsItem} from "./queries";
import MultiLanguageText from '../Generic/MultiLanguageText';

const NewsItemCover = ({newsItem}) => {
    const {t} = useTranslation('generic');
    const queryCache = useQueryCache();
    const created_at = new Date(newsItem.created_at);

    const onClickRemove = (id) => {
        removeNewsItem(id).then(() => {
            return queryCache.invalidateQueries('newsitems');
        });
    }

    return <div className='newsitem'>
        <Row className='newscontent'>
            <Col lg={12}>
                <Image src={newsItem.articlephoto_url_normal} className='thumbnail'/>
                <h2>
                    <Link  to={`/newsitems/${newsItem.id}`} className='newslink'>
                        <MultiLanguageText nl={newsItem.title} en={newsItem.title_en}/>
                    </Link>
                </h2>
                <p>
                    {created_at.toLocaleDateString().concat(' | ').concat(newsItem.user.name)}
                </p>
                <p>
                    <MultiLanguageText nl={newsItem.news} en={newsItem.news_en}/>
                </p>
                <Can I="update" this={subject('Newsitem', newsItem)}>
                    <Button size='sm' variant='warning' as={Link} to={`/newsitems/${newsItem.id}/edit`}>
                        {t('edit')}
                    </Button>
                </Can>
                <Can I="destroy" this={subject('Newsitem', newsItem)}>
                    <Button size='sm' variant='danger' onClick={() => onClickRemove(newsItem.id)}>
                        {t('remove')}
                    </Button>
                </Can>
            </Col>
        </Row>
    </div>
}
const NewsItems = () => {
    const { isLoading, isError, data: newsItems, error } = useQuery('newsitems', getNewsItems)
    const {t} = useTranslation('newsItemPage');

    const Item = ({item}) => <NewsItemCover newsItem={item}/>
    return (<React.Fragment>
        <Row>
            <Col lg={12}>
                <h1>{t('news')}</h1>
            </Col>
        </Row>
        <Row>
            {isLoading && <DefaultSpinner/>}
            {newsItems && newsItems.length > 0 && <Paginate data={newsItems} itemsPerPage={8} colSize={{lg: 8}} Item={Item} />}
        </Row>
        <Row>
            <Col lg={12}>
                <Can I="create" a='Newsitem'>
                    <Button size='sm' variant='warning' as={Link} to={`/newsitems/new`}>
                        {t('generic:new')}
                    </Button>
                </Can>
            </Col>
        </Row>
    </React.Fragment>);
}

export default NewsItems