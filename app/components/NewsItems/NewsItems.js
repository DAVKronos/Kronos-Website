import React from 'react'
import {getNewsItems} from "../HomePage/queries";
import {useQuery} from 'react-query'
import {useTranslation} from 'react-i18next'
import {Button, Col, Row} from 'react-bootstrap'
import {Link} from 'react-router-dom'
import DefaultSpinner from "../Generic/Spinner";
import Paginate from "../Generic/Paginate";
import ShortNewsItem from "./ShortNewsItem";
import {Can} from "../../utils/auth-helper";

const NewsItems = () => {
    const {isLoading, isError, data, error} = useQuery('newsitems', getNewsItems)
    const {t} = useTranslation('newsItemPage')

    return (
        <>
            <Row>
                <Col lg={12}>
                    <h1>{t('news')}</h1>
                </Col>
            </Row>
            <Row>
                <Col lg={12}>
                    {isLoading && <DefaultSpinner/>}
                    {data && data.length > 0 && <Paginate data={data} itemsPerPage={8} colSize={{lg: 8}}
                                                          Item={({item}) => <ShortNewsItem item={item}/>}/>}
                </Col>
            </Row>
            <Row>
                <Col lg={12}>
                    <Can I='create' a='Newsitem'>
                        <Button as={Link} to='/newsitems/new'>
                            {t('new')}
                        </Button>
                    </Can>
                </Col>
            </Row>
        </>
    )
}

export default NewsItems