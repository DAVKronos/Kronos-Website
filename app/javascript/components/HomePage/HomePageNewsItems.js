import React from "react";
import ShortNewsItem from "./ShortNewsItem";
import NewsItemCarousel from "./NewsItemCarousel";
import {getNewsItems} from "./queries";
import DefaultSpinner from "../Spinner";
import {useQuery} from "react-query";


const NewsItems = (props) => {
    const { isLoading, isError, data, error } = useQuery('newsitems', getNewsItems)

    if (isLoading) {
        return <DefaultSpinner />;
    }
    console.log(data);
    return <div>
        <NewsItemCarousel items={data.slice(0, 2)}/>
        {data.sort(sort_newsItems).map(item => {
            return <ShortNewsItem key={item.id} item={item}/>
        })}
    </div>
}

function sort_newsItems(a, b) {
    return b.created_at - a.created_at;
}


export default NewsItems;