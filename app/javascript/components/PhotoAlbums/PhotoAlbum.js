import React from 'react';
import {Link} from 'react-router-dom';
import {Row, Col, Card, Pagination} from 'react-bootstrap';
import {getAPIHostUrl, PhotoAlbumsCollection, transformObject} from "../../utils/rest-helper";
import format from '../../utils/date-format';
import withData from "../../utils/withData";

class PhotoAlbum extends React.Component {
    state = {
        page: 1
    }


    changePage(page) {
        // page = page < 1 ? 1 : page;
        if (page !== this.state.page) {
            this.setState({page});
        }
    }

    render() {
        let photoAlbum = this.props.data;
        if (!photoAlbum){
            return null;
        }
        let  {page} = this.state;
        if (!photoAlbum.photos || photoAlbum.photos.length === 0){
            return <h3>Geen foto's</h3>
        }


        let photos = photoAlbum.photos || [];
        photoAlbum = transformObject(photoAlbum.photoalbum);
        let {id} = this.props.match.params;
        let pageNumbers = [];
        const photosPerPage = 12;
        let pages = Math.ceil(photos.length / photosPerPage);
        for (let number = 1; number <= pages; number++) {
            pageNumbers.push(
                <Pagination.Item key={number} onClick={() => this.changePage(number)}
                                 active={number === page}>
                    {number}
                </Pagination.Item>,
            );
        }

        let photosPage = photos.slice((page-1)*photosPerPage, page * photosPerPage);

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
                        <Pagination.Prev disabled={page===1} onClick={() => this.changePage(page - 1 )}/>
                        {pageNumbers}
                        <Pagination.Next disabled={page === photos.length} onClick={() => this.changePage(page + 1 )}/>
                    </Pagination>
                </Col>
            </Row>
        </React.Fragment>;
    }
}

export default withData(PhotoAlbum, (props) => PhotoAlbumsCollection.get(props.match.params.id));