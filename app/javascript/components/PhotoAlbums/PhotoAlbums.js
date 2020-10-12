import React from 'react';
import {Col, Row} from 'react-bootstrap';
import PhotoAlbumCover from "./PhotoAlbumCover";
import {PhotoAlbumsCollection} from "../../utils/rest-helper";
import withData from "../../utils/withData";
import DefaultSpinner from "../Spinner";
import {useQuery} from "react-query";
import {getPhotoAlbums} from "./queries";


function PhotoAlbums(props) {
    const { isLoading, isError, data, error } = useQuery('photoalbums', getPhotoAlbums)
    const photoAlbums = data;
    return <React.Fragment>
        <Row>
            <Col><h1>Fotoalbum</h1></Col>
        </Row>
        <Row>
            {isLoading && <DefaultSpinner/>}
            {photoAlbums && photoAlbums.map(photoAlbum => {
                return <Col key={photoAlbum.id} sm={6} md={4}>
                    <PhotoAlbumCover photoAlbum={photoAlbum}/>
                </Col>
            })}
        </Row>
    </React.Fragment>;
}

function sortPhotoAlbums(a,b) {
    return b.created_at - a.created_at;
}


export default PhotoAlbums;