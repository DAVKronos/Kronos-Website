import React from "react";
import {PagesCollection} from "../../utils/rest-helper";
import ReactMarkdown from 'react-markdown';
import withData from "../../utils/withData";
import Spinner from "../Spinner";


function Page(props) {
    if (props.loading) {
        return <Spinner />;
    }

    if (!props.data) {
        return <h1>Page not found</h1>;
    }

    let {pagetag, information} = props.data;
    return <div>
        <h1>{pagetag}</h1>
        <ReactMarkdown source={information}/>
    </div>;
}

function dataFunction(props) {
    let {id, pagetag} = props.match.params;
    if (id != null) {
        return PagesCollection.get(id);
    }
    return PagesCollection.getAll().then(pages => {

        return pages.find(page => page.pagetag.indexOf(pagetag) > -1)
    });

}

export default withData(Page, (props) => dataFunction(props))