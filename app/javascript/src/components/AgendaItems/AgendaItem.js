import React from 'react';
import ReactMarkdown from 'react-markdown';
import {Button, Card, Col, Row} from 'react-bootstrap';
import {AgendaItemTypeName} from './AgendaItemType';
import {BsGeoAlt, BsClock, BsList, BsLink} from 'react-icons/bs';


import {format} from '../../utils/date-format';
import EventsResults from "./EventsResults";
import {useQuery} from "react-query";
import {getAgendaitem, removeAgendaitem, getPhotoalbums} from "./queries";
import DefaultSpinner from "../Generic/Spinner";
import MultiLanguageText from "../Generic/MultiLanguageText";
import {Can} from '../../utils/auth-helper';


import {Link, useHistory} from "react-router-dom";
import {useTranslation} from "react-i18next";
import {subject} from "@casl/ability";
import SubscriptionsCard from "./Components/SubscriptionsCard";
import AgendaItemEventsCard from "./Components/AgendaItemEventsCard";


function AgendaItem(props) {
    const {t, i18n} = useTranslation('generic');
    const lang = i18n.language;
    const history = useHistory();
    const id = parseInt(props.match.params.id);
    const {isLoading, isError, data: agendaItem, error} = useQuery(['agendaitems', id], getAgendaitem)
    const {isLoading2, isError2, data: photoAlbums, error2} = useQuery('photoalbums',getPhotoalbums)
    if (isLoading) {
        return <DefaultSpinner/>;
    }
    if (!agendaItem) {
        return null;
    }
    const onClickRemove = () => {
        removeAgendaitem(id).then(() => {
            history.push('/agendaitems')
        })
    }

    let date = new Date(agendaItem.date);
    
    const renderDescription = (text) => {   
        return <ReactMarkdown source={text}/>;
    }


    return <React.Fragment>
        <Row>
            <Col md={8}>
                <h1><MultiLanguageText nl={agendaItem.name} en={agendaItem.name_en}/> <small><AgendaItemTypeName id={agendaItem.agendaitemtype_id}/></small></h1>
            </Col>

            <Col md={4} className="d-flex">
                <Can I='update' this={subject('Agendaitem', agendaItem)}>
                    <Button variant='warning' className='align-self-center' as={Link}
                            to={`/agendaitems/${id}/edit`}>{t('edit')}</Button>
                </Can>
                <Can I='delete' this={subject('Agendaitem', agendaItem)}>
                    <Button variant='danger' className='align-self-center' onClick={onClickRemove}>
                        {t('remove')}
                    </Button>
                </Can>

                <Can I='create' a='Result'>
                    <Button variant='primary' className='align-self-center'
                            as={Link} to={`/agendaitems/${id}/events`} >{t('models:modelNames.result_plural')}</Button>
                </Can>
            </Col>
        </Row>
        <Row>
            <Col md={8}>
                <Row>
                    <Col xs={1}><BsClock/></Col>
                    <Col xs={11}>{format(date, 'PPP p', lang)}</Col>
                </Row>
                {agendaItem.location && <Row>
                    <Col xs={1}><BsGeoAlt/></Col>
                    <Col xs={11}>{agendaItem.location}</Col>
                </Row>
                }
                {agendaItem.url && <Row>
                    <Col xs={1}><BsLink/></Col>
                    <Col xs={11}><a href={`http://${agendaItem.url}`}>{agendaItem.url}</a></Col>
                </Row>
                }
                {agendaItem.commission && <Row>
                    <Col xs={1}><BsGeoAlt/></Col>
                    <Col xs={11}>{agendaItem.commission}</Col>
                </Row>}
                <Row>
                    <Col xs={1}><BsList/></Col>
                    <Col xs={11}><MultiLanguageText nl={agendaItem.description} en={agendaItem.description_en} renderFunction={renderDescription}/></Col>
                </Row>
                {photoAlbums && photoAlbums.filter(p => p.id === agendaItem.id).length>0 &&
                <Row>
                    <Col>
                        <h3><MultiLanguageText nl='Fotos' en='Photos'/></h3>
                    </Col>
                </Row>}
                {photoAlbums && photoAlbums.filter(p => p.id === agendaItem.id).length>0 &&
                photoAlbums.filter(p => p.agendaitem_id === agendaItem.id).map(photoalbum => {
                return <Row key ={photoalbum.id}>
                    <Col xs={12}>
                        <Link  to={`/photoalbums/${photoalbum.id}`}><MultiLanguageText nl={photoalbum.name} en={photoalbum.name_en}/></Link>
                    </Col>
                </Row>
                })
                }
                <Row>
                    <Col>
                    <EventsResults agendaItemId={agendaItem.id}/>
                    </Col>
                </Row>
            </Col>

            <Col md={4}>
                <AgendaItemEventsCard agendaItemId={agendaItem.id} agendaItemTypeId={agendaItem.agendaitemtype_id}/>
                <Can I="read" a="Subscription" passThrough>
                    {allowed => <SubscriptionsCard agendaItem={agendaItem} allowed={allowed}/>}
                </Can>
            </Col>
        </Row>
    </React.Fragment>
}

export default AgendaItem