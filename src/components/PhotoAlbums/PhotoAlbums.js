import React from 'react';
import {Button, Col, Row} from 'react-bootstrap';
import PhotoAlbumCover from "./PhotoAlbumCover";
import DefaultSpinner from "../Generic/Spinner";
import {useQuery} from "react-query";
import {getPhotoAlbums, removePhotoAlbum} from "./queries";
import {Link} from "react-router-dom";
import {Can} from "../../utils/auth-helper";
import {useTranslation} from "react-i18next";

function PhotoAlbums(props) {
    const { isLoading, isError, data, error } = useQuery('photoalbums', getPhotoAlbums);
    const {t} = useTranslation('generic');
    const photoAlbums = data;


    return <React.Fragment>
        <Row>
            <Col><h1>{t('photoAlbumPage:header')}</h1></Col>
        </Row>
        <Row>
            {isLoading && <DefaultSpinner/>}
            {photoAlbums && photoAlbums.map(photoAlbum => {
                return <Col key={photoAlbum.id} sm={6} md={4}>
                    <PhotoAlbumCover photoAlbum={photoAlbum}/>
                </Col>
            })}
        </Row>
        <Can I='create' a='Photoalbum'>
            <Button as={Link} to='/photoalbums/new'>{t('addModel', {model: t('models:modelNames.photoAlbum')})}</Button>
        </Can>
    </React.Fragment>;
}

function sortPhotoAlbums(a,b) {
    return b.created_at - a.created_at;
}


export default PhotoAlbums;