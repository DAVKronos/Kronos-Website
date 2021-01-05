import React from "react";
import ReactMarkdown from 'react-markdown';
import Spinner from "../Generic/Spinner";
import {useQuery} from "react-query";
import {getPage, getPageByPageTag} from "./queries";


const Page = (props) => {

    let {id} = props.match.params;
    const { isLoading, isError, data, error } = useQuery(['pages', id], getPage)

    if (isLoading) {
        return <Spinner />;
    }

    if (!data) {
        return <h1>Page not found</h1>;
    }

    return <div>
        <h1>{data.pagetag}</h1>
        <ReactMarkdown source={data.information}/>
    </div>;
}

const PageWithTag = (props) => {

    let {pagetag} = props.match.params;
    const { isLoading, isError, data, error } = useQuery(['pages', pagetag], getPageByPageTag)

    if (isLoading) {
        return <Spinner />;
    }

    if (!data) {
        return <h1>Page not found</h1>;
    }

    return <div>
        <h1>{data.pagetag}</h1>
        <ReactMarkdown source={data.information}/>
    </div>;
}


export {Page, PageWithTag}