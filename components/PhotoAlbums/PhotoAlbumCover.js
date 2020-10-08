import React from 'react';
import {Card} from 'react-bootstrap';
import {Link} from 'react-router-dom';
import {getAPIHostUrl, PhotoAlbumsCollection} from "../../utils/rest-helper";
import format from '../../utils/date-format';
import withData from "../../utils/withData";
import DefaultSpinner from "../Spinner";

const PhotoAlbumCover = (props) => {
    let {photoAlbum, data: photoAlbumData, loading} = props;
    let photoThumb = photoAlbumData && photoAlbumData.photos && photoAlbumData.photos[0] && photoAlbumData.photos[0].photo_url_thumb;

    return <Card style={{marginBottom: 10}}>
        {loading && <DefaultSpinner />}
        {photoAlbumData && <Card.Img variant="top" src={getAPIHostUrl(photoThumb)} />}
        <Card.Body>
            <Card.Title><Link to={`/photoalbums/${photoAlbum.id}`}>{photoAlbum.name}</Link></Card.Title>
            <Card.Text>
                {photoAlbum.created_at && format(photoAlbum.created_at, 'PPP p')}
            </Card.Text>
        </Card.Body>
    </Card>
};

function dataFunction(photoAlbumId) {
    return PhotoAlbumsCollection.get(photoAlbumId)
}

export default withData(PhotoAlbumCover, (props) => dataFunction(props.photoAlbum.id));