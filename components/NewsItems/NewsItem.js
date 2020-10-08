import React from "react";
import {Col, Row} from 'react-bootstrap';
import {getAPIHostUrl, NewsItemsCollection} from "../../utils/rest-helper";
import format from '../../utils/date-format';
import withData from "../../utils/withData";


function NewsItem(props) {
    let item = props.data;
    if (!item) {
        return null;
    }
    return  <React.Fragment>
        <Row>
            <Col md={{span: 8, offset: 2}}>
                <h1>{item.title}</h1>
                <p>{format(item.created_at, 'PPP p')} | {item.user.name}</p>
            </Col>
        </Row>
        <Row>
            <Col md={{span: 8, offset: 2}}>
                <img src={getAPIHostUrl(item.articlephoto_url_carrousel)} alt={item.title}/>
                <p>{item.news}</p>
            </Col>
        </Row>
    </React.Fragment>
}

export default withData(NewsItem, (props) => NewsItemsCollection.get(props.match.params.id));