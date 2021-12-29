import React from "react";
import {useQueryCache} from "react-query";
import {useHistory} from "react-router-dom";
import NewObjectComponent from "../Generic/NewObjectComponent";
import { createMailingList} from "./queries";
import MailingListForm from "./MailingListForm";

const NewMailingList = () => {

    const queryCache = useQueryCache();
    const history = useHistory();

    
    const onSuccess = (savedMailingList) => {
        queryCache.setQueryData(['mailinglists', savedMailingList.id], savedMailingList)
        queryCache.invalidateQueries('mailinglists');
        history.push(`/admin/mailinglists`)
    }

    return <NewObjectComponent
        objectName='mailingList'
        createFunction={createMailingList}
        onSuccess={onSuccess}
        FormComponent={MailingListForm}
    />
}

export default NewMailingList