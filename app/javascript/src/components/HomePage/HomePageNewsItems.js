import React from "react";
import ShortNewsItem from "./ShortNewsItem";
import NewsItemCarousel from "./NewsItemCarousel";
import {getNewsItems} from "./queries";
import DefaultSpinner from "../Generic/Spinner";
import {useQuery} from "react-query";
import {Button} from "react-bootstrap";
import {useTranslation} from "react-i18next";
import {Can} from "../../utils/auth-helper";
import {Link} from "react-router-dom";


const NewsItems = (props) => {
    const { isLoading, isError, data, error } = useQuery('newsitems', getNewsItems)
    const {t} = useTranslation('generic');
    if (isLoading) {
        return <DefaultSpinner />;
    }
    return <div>
        <NewsItemCarousel items={data.slice(0, 2)}/>
        {data.sort(sort_newsItems).map(item => {
            return <ShortNewsItem key={item.id} item={item}/>
        })}
        <Can I={'create'} a={'Newsitem'}>
            <Button as={Link} to={'/newsitems/new'}>{t('add')} news item</Button>
        </Can>
    </div>
}

function sort_newsItems(a, b) {
    return b.created_at - a.created_at;
}


export default NewsItems;