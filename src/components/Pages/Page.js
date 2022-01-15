import React from "react";
import ReactMarkdown from 'react-markdown';
import Spinner from "../Generic/Spinner";
import {useQuery} from "react-query";
import {getPage, getPageByPageTag} from "./queries";
import MultiLanguageText from "../Generic/MultiLanguageText";

const PageComponent = ({page, isLoading}) => {
    if (isLoading) {
        return <Spinner />;
    }

    if (!page) {
        return <h1>Page not found</h1>;
    }

    const renderMarkdown = (text) => {
        return <ReactMarkdown source={text} escapeHtml={false}/>;
    }

    return <div>
        <h1><MultiLanguageText nl={page.pagetag} en={page.pagetag_en}/></h1>
        <MultiLanguageText nl={page.information} en={page.information_en} renderFunction={renderMarkdown} />
    </div>;
}


const Page = (props) => {
    let {id} = props.match.params;
    const { isLoading, isError, data, error } = useQuery(['pages', id], getPage)

    return <PageComponent page={data} isLoading={isLoading}/>;
}

const PageWithTag = (props) => {
    let {pagetag} = props.match.params;
    const { isLoading, isError, data, error } = useQuery(['pages', pagetag], getPageByPageTag)

    return <PageComponent page={data} isLoading={isLoading}/>;
}


export {Page, PageWithTag}