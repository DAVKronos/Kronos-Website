import React from 'react';
import {Button, ButtonGroup, Col, Image, Row} from 'react-bootstrap';
import {NavLink} from 'react-router-dom';
import {getAPIHostUrl} from "../../utils/rest-helper";
import {useQuery} from "react-query";
import {getPhotoAlbum} from "./queries";


function Photo(props) {
    const id = props.match.params.album_id;
    const { isLoading, isError, data, error } = useQuery(['photoalbums', id], getPhotoAlbum)
    let photoAlbum = data;
    if (!photoAlbum) {
        return null;
    }

    let photos = photoAlbum.photos || [];
    photoAlbum = photoAlbum.photoalbum;
    let {photo_id, album_id} = props.match.params;
    photo_id = parseInt(photo_id);

    let photoIndex = photos.findIndex(item => item.id === photo_id)
    if (photoIndex < 0) {
        return <h3>Foto niet gevonden</h3>;
    }

    let photo = photos[photoIndex];

    let prevPhoto = photoIndex > 0 ? photos[photoIndex - 1] : photo;
    let nextPhoto = photoIndex < photos.length - 1 ? photos[photoIndex + 1] : photo;
    return <React.Fragment>
        <Row><Col>
            <h1>{photoAlbum.name}</h1>
            <p>{photoAlbum.date}</p>
        </Col></Row>
        <Row>
            <Col style={{display: 'flex', justifyContent: 'center'}}>
                <Image style={{maxWidth: '100%', maxHeight: 400}} src={getAPIHostUrl(photo.photo_url_normal)}/>
            </Col>
        </Row>
        <Row style={{marginTop: 20}}>
            <Col style={{display: 'flex', justifyContent: 'center'}}>
                <ButtonGroup>
                    <Button disabled={photoIndex === 0} as={NavLink}
                            to={`/photoalbums/${album_id}/${prevPhoto.id}`}>
                        Previous
                    </Button>
                    <Button disabled={photoIndex === photos.length - 1}
                            as={NavLink} to={`/photoalbums/${album_id}/${nextPhoto.id}`}>
                        Next
                    </Button>
                </ButtonGroup>

            </Col>
        </Row>
    </React.Fragment>;
}

export default Photo