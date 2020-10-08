import React from "react";
import {Carousel} from "react-bootstrap";
import {getAPIHostUrl} from "../../utils/rest-helper";

const NewsItemCaroursel = ({items}) => {
    return <Carousel pause={false} interval={3000}>
        {items.map(item => {
            return <Carousel.Item key={item.id} style={{height: 260}}>
                <img
                    className="d-block w-100"
                    src={getAPIHostUrl(item.articlephoto_url_carrousel)}
                    alt={item.title}
                />
                <Carousel.Caption>
                    <h3>{item.title}</h3>
                </Carousel.Caption>
            </Carousel.Item>
        })}


    </Carousel>
        ;
};

export default NewsItemCaroursel;