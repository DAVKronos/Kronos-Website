import React from 'react';
import {Card} from 'react-bootstrap';
import {Link} from 'react-router-dom';
import {getAPIHostUrl, PhotoAlbumsCollection} from "../../utils/rest-helper";
import format from '../../utils/date-format';
import withData from "../../utils/withData";
import DefaultSpinner from "../Spinner";
import {useQuery} from "react-query";
import {getPhotoAlbum} from "./queries";

const PhotoAlbumCover = (props) => {
    const id = props.photoAlbum.id;
    const { isLoading, isError, data, error } = useQuery(['photoalbums', id], getPhotoAlbum)


    let {photoAlbum} = props;
    const photoAlbumData = data;
    let photoThumb = photoAlbumData && photoAlbumData.photos && photoAlbumData.photos[0] && photoAlbumData.photos[0].photo_url_thumb;

    return <Card style={{marginBottom: 10}}>
        {isLoading && <DefaultSpinner />}
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

export default PhotoAlbumCover