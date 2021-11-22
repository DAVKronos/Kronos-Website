import React from "react";
import {useQueryCache} from "react-query";
import {useHistory} from "react-router-dom";
import NewObjectComponent from "../Generic/NewObjectComponent";
import { createPage} from "./queries";
import PageForm from "./PageForm";

const NewPage = () => {

    const queryCache = useQueryCache();
    const history = useHistory();

    
    const onSuccess = (savedPage) => {
        queryCache.setQueryData(['pages', savedPage.id], savedPage)
        queryCache.invalidateQueries('pages');
        history.push(`/pages/${savedPage.id}`)
    }

    return <NewObjectComponent
        objectName='page'
        createFunction={createPage}
        onSuccess={onSuccess}
        FormComponent={PageForm}
    />
}

export default NewPage