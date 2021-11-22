import React from "react";
import ReactMarkdown from 'react-markdown';
import Spinner from "../Generic/Spinner";
import {useQuery} from "react-query";
import {useTranslation} from "react-i18next";
import {getPage, getPageByPageTag} from "./queries";


const Page = (props) => {

    let {id} = props.match.params;
    const {t, i18n} = useTranslation('generic');
    const { isLoading, isError, data, error } = useQuery(['pages', id], getPage)

    if (isLoading) {
        return <Spinner />;
    }

    if (!data) {
        return <h1>Page not found</h1>;
    }

    const tag = i18n.language === 'nl' ? data.pagetag : data.pagetag_en;
    const information = i18n.language === 'nl' ? data.information : data.information_en;
    return <div>
        <h1>{tag}</h1>
        <ReactMarkdown source={information}/>
    </div>;
}

const PageWithTag = (props) => {

    let {pagetag} = props.match.params;
    const {t, i18n} = useTranslation('generic');
    const { isLoading, isError, data, error } = useQuery(['pages', pagetag], getPageByPageTag)

    if (isLoading) {
        return <Spinner />;
    }

    if (!data) {
        return <h1>Page not found</h1>;
    }

    const tag = i18n.language === 'nl' ? data.pagetag : data.pagetag_en;
    const information = i18n.language === 'nl' ? data.information : data.information_en;
    return <div>
        <h1>{tag}</h1>
        <ReactMarkdown source={information}/>
    </div>;
}


export {Page, PageWithTag}