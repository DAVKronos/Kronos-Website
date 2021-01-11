import React from 'react';
import {Button, ButtonGroup, Col, Image, Row} from 'react-bootstrap';
import {Link, NavLink} from 'react-router-dom';
import {getAPIHostUrl} from "../../utils/rest-helper";
import {useQuery} from "react-query";
import {getPhotoAlbum, getPhotos} from "./queries";
import {useTranslation} from "react-i18next";
import DefaultSpinner from "../Generic/Spinner";


function Photo(props) {
    let {photo_id, album_id} = props.match.params;
    const {t} = useTranslation('generic');
    const { isLoading:albumLoading, isError, data: photoAlbum, error } = useQuery(['photoalbums', album_id], getPhotoAlbum)
    const { isLoading:photosLoading, data: photos } = useQuery(['photos', album_id], getPhotos);
    if (albumLoading || photosLoading) {
        return <DefaultSpinner />;
    }

    if (!photoAlbum || !photos) {
        return null;
    }

    photo_id = parseInt(photo_id);

    let photoIndex = photos.findIndex(item => item.id === photo_id)
    if (photoIndex < 0) {
        return <h3>{t('not_found')}</h3>;
    }

    let photo = photos[photoIndex];

    let prevPhoto = photoIndex > 0 ? photos[photoIndex - 1] : photo;
    let nextPhoto = photoIndex < photos.length - 1 ? photos[photoIndex + 1] : photo;
    return <div className="photo-container">
        <Row>
            <Col>
                <h1>{photoAlbum.name}</h1>
                <p>{photoAlbum.date}</p>
            </Col>
        </Row>
        <Row>
            <Col className="photo" >
                <Image src={getAPIHostUrl(photo.photo_url_original)}/>
            </Col>
        </Row>
        <Row className="row-margin" >
            <Col className="photo-buttons">
                <Button as={Link} to={`/photoalbums/${album_id}`}>{t('back')}</Button>
                <ButtonGroup>
                    <Button disabled={photoIndex === 0} as={NavLink}
                            to={`/photoalbums/${album_id}/${prevPhoto.id}`}>
                        {t('previous')}
                    </Button>
                    <Button disabled={photoIndex === photos.length - 1}
                            as={NavLink} to={`/photoalbums/${album_id}/${nextPhoto.id}`}>
                        {t('next')}
                    </Button>
                </ButtonGroup>

            </Col>
        </Row>
    </div>;
}

export default Photo