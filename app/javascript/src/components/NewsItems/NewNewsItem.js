import React from 'react';
import {createNewsItem} from "./queries";
import { useQueryCache} from "react-query";
import {useHistory} from "react-router-dom";
import NewObjectComponent from "../Generic/NewObjectComponent";
import NewsItemForm from "./NewsItemForm";

const NewNewsItem = () => {
    const queryCache = useQueryCache();
    const history = useHistory();
    const onSuccess = (newsItem) => {
        queryCache.setQueryData(['newsitems', newsItem.id], newsItem)
        history.push(`/newsitems/${newsItem.id}`)
    }


    return <NewObjectComponent
        objectName={'Newsitem'}
        FormComponent={NewsItemForm}
        createFunction={createNewsItem}
        onSuccess={onSuccess}
    />

};

export default NewNewsItem