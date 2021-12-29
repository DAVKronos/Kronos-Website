import React from "react";
import {useQuery, useQueryCache} from "react-query";
import DefaultSpinner from "../Generic/Spinner";
import {useHistory} from "react-router-dom";
import EditObjectComponent from "../Generic/EditObjectComponent";
import {getPage, updatePage} from "./queries";
import PageForm from "./PageForm";

const EditPageWithData = (props) => {
    const id = parseInt(props.match.params.id);;
    const { isLoading, isError, data, error } = useQuery(['pages', id], getPage);
    if (isLoading) {
        return <DefaultSpinner />;
    }
    return data && <EditPage page={data} />
}

const EditPage = ({page}) => {

    const queryCache = useQueryCache();
    const history = useHistory();
    const {id, pagetag, pagetag_en, menu, highlight, sort_order, information, information_en} = page;

    const editableFields = {pagetag, pagetag_en, menu, highlight, "public": page['public'], sort_order, information, information_en};
    const onSuccess = (savedPage) => {
        queryCache.setQueryData(['pages', savedPage.id], savedPage);
        queryCache.invalidateQueries(['pages'], {exact: true});
        
        history.push(`/pages/${savedPage.id}`);
        
    }

    return <EditObjectComponent
        id={id}
        existingObject={editableFields}
        objectName='page'
        updateFunction={updatePage}
        onSuccess={onSuccess}
        FormComponent={PageForm}
    />
}

export default EditPageWithData