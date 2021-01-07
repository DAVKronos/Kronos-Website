import React from 'react';
import {Button, Card} from 'react-bootstrap';
import {Link, useHistory} from 'react-router-dom';
import {getAPIHostUrl} from "../../utils/rest-helper";
import {format} from '../../utils/date-format';
import DefaultSpinner from "../Generic/Spinner";
import {useQuery, useQueryCache} from "react-query";
import {getPhotoAlbum, removePhotoAlbum} from "./queries";
import {subject} from "@casl/ability";
import {Can} from "../../utils/auth-helper";
import {useTranslation} from "react-i18next";

const PhotoAlbumCover = (props) => {
    const id = props.photoAlbum.id;
    const queryCache = useQueryCache();
    const {t} = useTranslation('generic');
    const { isLoading, isError, data, error } = useQuery(['photoalbums', id], getPhotoAlbum)


    let {photoAlbum} = props;
    const photoAlbumData = data;
    let photoThumb = photoAlbumData && photoAlbumData.photos && photoAlbumData.photos[0] && photoAlbumData.photos[0].photo_url_thumb;

    const onClickRemove = () => {
        removePhotoAlbum(id).then(() => {
            return queryCache.invalidateQueries('photoalbums');
        });
    }

    return <Card style={{marginBottom: 10}}>
        {isLoading && <DefaultSpinner />}
        {photoAlbumData && <Card.Img variant="top" src={getAPIHostUrl(photoThumb)} />}
        <Card.Body>
            <Card.Title><Link to={`/photoalbums/${photoAlbum.id}`}>{photoAlbum.name}</Link></Card.Title>
            <Card.Text>
                {photoAlbum.created_at && format(photoAlbum.created_at, 'PPP p')}
            </Card.Text>
            <Can I="update" this={subject('Photoalbum', photoAlbum)}>
                <Button size='sm' variant='warning' as={Link} to={`/photoalbums/${id}/edit`}>
                    {t('edit')}
                </Button>
            </Can>
            <Can I="delete" this={subject('Photoalbum', photoAlbum)}>
                <Button size='sm' variant='danger' onClick={() => onClickRemove(photoAlbum.id)}>
                    {t('remove')}
                </Button>
            </Can>
        </Card.Body>
    </Card>
};


export default PhotoAlbumCover