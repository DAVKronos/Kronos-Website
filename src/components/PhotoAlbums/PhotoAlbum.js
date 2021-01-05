import React, {useState} from 'react';
import {Link} from 'react-router-dom';
import {Row, Col, Card, Pagination} from 'react-bootstrap';
import {getAPIHostUrl, transformObject} from "../../utils/rest-helper";
import {format}  from '../../utils/date-format';
import {useQuery} from "react-query";
import {getPhotoAlbum} from "./queries";


const PhotoAlbum = (props) => {

    const id = props.match.params.id;
    const [currentPage, setCurrentPage] = useState(1);

    const { isLoading, isError, data, error } = useQuery(['photoalbums', id], getPhotoAlbum)
    let photoAlbum = data;
    if (!photoAlbum){
        return null;
    }
    if (!photoAlbum.photos || photoAlbum.photos.length === 0){
        return <h3>Geen foto's</h3>
    }


    let photos = photoAlbum.photos || [];
    photoAlbum = transformObject(photoAlbum.photoalbum);
    let pageNumbers = [];
    const photosPerPage = 12;
    let pages = Math.ceil(photos.length / photosPerPage);
    for (let number = 1; number <= pages; number++) {
        pageNumbers.push(
            <Pagination.Item key={number} onClick={() => this.changePage(number)}
                             active={number === currentPage}>
                {number}
            </Pagination.Item>,
        );
    }

    let photosPage = photos.slice((currentPage-1)*photosPerPage, currentPage * photosPerPage);

    return <React.Fragment>
        <Row><Col>
            <h1>{photoAlbum.name}</h1>
            <p>aangemaakt: {format(photoAlbum.created_at, 'PPP p')}</p>
        </Col></Row>
        <Row>
            {photosPage && photosPage.map(photo => {
                return <Col key={photo.id} md={4} sm={4}>
                    <Link to={`/photoalbums/${id}/${photo.id}`}>
                        <Card>
                            <Card.Img src={getAPIHostUrl(photo.photo_url_thumb)}/>
                        </Card>
                    </Link>
                </Col>;
            })}
        </Row>
        <Row style={{marginTop: 20}}>
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