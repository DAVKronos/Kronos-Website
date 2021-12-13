import React from "react";
import {useQuery, useQueryCache} from "react-query";
import DefaultSpinner from "../Generic/Spinner";
import {useHistory} from "react-router-dom";
import EditObjectComponent from "../Generic/EditObjectComponent";
import {getMailingList, updateMailingList} from "./queries";
import MailingListForm from "./MailingListForm";

const EditMailingListWithData = (props) => {
    const id = parseInt(props.match.params.id);
    const { isLoading, isError, data, error } = useQuery(['mailinglists', id], getMailingList);
    if (isLoading) {
        return <DefaultSpinner />;
    }
    return data && <EditMailingList passedId={id} mailingList={data} />
}

const EditMailingList = ({mailingList, passedId}) => {

    const queryCache = useQueryCache();
    const history = useHistory();
    const {id, name, description, local_part, commission_id} = mailingList;
    const alias_ids = mailingList.aliases.map(v => v.id);
    const user_ids = mailingList.users.map(v => v.id);
    const editableFields = {name, description, local_part, commission_id, alias_ids, user_ids};
    const onSuccess = (savedMailingList) => {
        queryCache.setQueryData(['mailinglists', savedMailingList.id], savedMailingList)
        history.push(`/admin/mailinglists/`)
    }

    return <EditObjectComponent
        id={id}
        existingObject={editableFields}
        objectName='mailingList'
        updateFunction={updateMailingList}
        onSuccess={onSuccess}
        FormComponent={MailingListForm}
    />
}

export default EditMailingListWithData