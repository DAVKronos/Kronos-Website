import React from "react";
import {useQueryCache} from "react-query";
import {useHistory} from "react-router-dom";
import NewObjectComponent from "../../Generic/NewObjectComponent";
import { createFolder } from "../queries";
import FolderForm from "./FolderForm";

const NewFolder = () => {

    const queryCache = useQueryCache();
    const history = useHistory();

    
    const onSuccess = (savedFolder) => {
        queryCache.setQueryData(['folders', savedFolder.id], savedFolder)
        queryCache.invalidateQueries('folders');
        history.push(`/kronometers/${savedFolder.id}`)
    }

    return <NewObjectComponent
        objectName='folder'
        createFunction={createFolder}
        onSuccess={onSuccess}
        FormComponent={FolderForm}
    />
}

export default NewFolder