import React from 'react';
import {Col, Row} from 'react-bootstrap';
import PhotoAlbumCover from "./PhotoAlbumCover";
import {PhotoAlbumsCollection} from "../../utils/rest-helper";
import withData from "../../utils/withData";
import DefaultSpinner from "../Spinner";


function PhotoAlbums(props) {
    let {data: photoAlbums, loading} = props;
    return <React.Fragment>
        <Row>
            <Col><h1>Fotoalbum</h1></Col>
        </Row>
        <Row>
            {loading && <DefaultSpinner/>}
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

function dataFunction() {
    return PhotoAlbumsCollection.getAll({}).then(photoAlbums => {
        return  photoAlbums.sort(sortPhotoAlbums);
    });
}

export default withData(PhotoAlbums, () =>  dataFunction());