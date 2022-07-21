import React from "react";
import {useQuery, useQueryCache} from "react-query";
import DefaultSpinner from "../../Generic/Spinner";
import {useHistory} from "react-router-dom";
import EditObjectComponent from "../../Generic/EditObjectComponent";
import {getFolderById, updateFolder} from "../queries";
import FolderForm from "./FolderForm";

const EditFolderWithData = (props) => {
    const id = parseInt(props.match.params.id);;
    const { isLoading, isError, data, error } = useQuery(['folders', id], getFolderById);
    if (isLoading) {
        return <DefaultSpinner />;
    }
    return data && <EditFolder folder={data} />
}

const EditFolder = ({folder}) => {

    const queryCache = useQueryCache();
    const history = useHistory();
    const {id, name, folder_id} = folder;
    const editableFields = {name, folder_id};
    const onSuccess = (savedFolder) => {
        queryCache.setQueryData(['folders', savedFolder.id], savedFolder)
        history.push(`/kronometers/${savedFolder.id}`)
    }

    return <EditObjectComponent
        id={id}
        existingObject={editableFields}
        objectName='folder'
        updateFunction={updateFolder}
        onSuccess={onSuccess}
        FormComponent={FolderForm}
    />
}

export default EditFolderWithData