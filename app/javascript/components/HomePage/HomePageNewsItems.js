import React from "react";
import ShortNewsItem from "./ShortNewsItem";
import NewsItemCarousel from "./NewsItemCarousel";
import {NewsItemsCollection} from "../../utils/rest-helper";
import withData from "../../utils/withData";


function NewsItems(props) {
    const items = props.data || [];
    return <div>
        <NewsItemCarousel items={items.slice(0, 2)}/>
        {items.sort(sort_newsItems).map(item => {
            return <ShortNewsItem key={item.id} item={item}/>
        })}
    </div>
}

function sort_newsItems(a, b) {
    return b.created_at - a.created_at;
}


export default withData(NewsItems, () => NewsItemsCollection.getAll() );