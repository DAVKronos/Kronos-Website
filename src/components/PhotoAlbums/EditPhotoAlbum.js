import React from "react";
import {useQuery, useQueryCache} from "react-query";
import DefaultSpinner from "../Generic/Spinner";
import {useHistory} from "react-router-dom";
import EditObjectComponent from "../Generic/EditObjectComponent";
import PhotoAlbumForm from "./PhotoAlbumForm";
import {getPhotoAlbum, updatePhotoAlbum} from "./queries";
import EditPhotos from "./EditPhotos";

const EditPhotoAlbumWithData = (props) => {
    const id = parseInt(props.match.params.id);;
    const { isLoading, isError, data, error } = useQuery(['photoalbums', id], getPhotoAlbum);
    if (isLoading) {
        return <DefaultSpinner />;
    }
    return data && <EditPhotoAlbum photoAlbum={data} />;
}

const EditPhotoAlbum = ({photoAlbum}) => {

    const queryCache = useQueryCache();
    const history = useHistory();
    const {id, name, name_en, public:public_status, date, external_url} = photoAlbum;
    const editableFields = {name, name_en, public:public_status, date, external_url};
    const onSuccess = (savedPhotoAlbum) => {
        queryCache.setQueryData(['photoalbums', savedPhotoAlbum.id], savedPhotoAlbum)
        history.push(`/photoalbums/${savedPhotoAlbum.id}`)
    }

    return <div><EditObjectComponent
        id={id}
        existingObject={editableFields}
        objectName='photoAlbum'
        updateFunction={updatePhotoAlbum}
        onSuccess={onSuccess}
        FormComponent={PhotoAlbumForm}
    />
    <EditPhotos photoAlbumId={id}/>
    </div>
}

export default EditPhotoAlbumWithData