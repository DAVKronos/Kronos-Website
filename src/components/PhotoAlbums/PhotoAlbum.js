import React, {useState} from 'react';
import {Link} from 'react-router-dom';
import {Row, Col, Card, Pagination} from 'react-bootstrap';
import {getAPIHostUrl} from "../../utils/rest-helper";
import {format}  from '../../utils/date-format';
import {useQuery} from "react-query";
import {getPhotoAlbum, getPhotos} from "./queries";
import {useTranslation} from "react-i18next";
import DefaultSpinner from "../Generic/Spinner";


const PhotoAlbum = (props) => {
    const id = props.match.params.id;
    const [currentPage, setCurrentPage] = useState(1);
    const {t, i18n} = useTranslation(['photoalbum', 'models']);

    const { isLoading:albumLoading, isError, data: photoAlbum, error } = useQuery(['photoalbums', id], getPhotoAlbum)
    const { isLoading:photosLoading, data: photos } = useQuery(['photos', id], getPhotos);

    if (albumLoading || photosLoading) {
        return <DefaultSpinner />;
    }


    if (!photoAlbum){
        return null;
    }
    if (!photos || photos.length === 0){
        return <h3>{t('no_photos')}</h3>
    }


    let pageNumbers = [];
    const photosPerPage = 12;
    let pages = Math.ceil(photos.length / photosPerPage);
    for (let number = 1; number <= pages; number++) {
        pageNumbers.push(
            <Pagination.Item key={number} onClick={() => setCurrentPage(number)}
                             active={number === currentPage}>
                {number}
            </Pagination.Item>,
        );
    }

    let photosPage = photos.slice((currentPage-1)*photosPerPage, currentPage * photosPerPage);

    return <React.Fragment>
        <Row>
            <Col>
                <h1>{photoAlbum.name}</h1>
                <p>{t('models:generic.created_at')}: {format(photoAlbum.created_at, 'PPP p', i18n.language)}</p>
            </Col>
        </Row>
        <Row>
            {photosPage && photosPage.map(photo => {
                return <Col key={photo.id} md={3} sm={4}>
                    <Link to={`/photoalbums/${id}/${photo.id}`}>
                        <Card>
                            <Card.Img src={getAPIHostUrl(photo.photo_url_thumb)}/>
                        </Card>
                    </Link>
                </Col>;
            })}
        </Row>
        <Row className="row-margin">
            <Col>
                <Pagination>
                    <Pagination.Prev disabled={currentPage===1} onClick={() => setCurrentPage(currentPage - 1 )}/>
                    {pageNumbers}
                    <Pagination.Next disabled={currentPage === pages} onClick={() => setCurrentPage(currentPage + 1 )}/>
                </Pagination>
            </Col>
        </Row>
    </React.Fragment>;
}

export default PhotoAlbum