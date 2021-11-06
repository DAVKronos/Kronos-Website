import React from 'react';
import {createAgendaitem} from "./queries";
import { useQueryCache} from "react-query";
import {useHistory} from "react-router-dom";
import AgendaItemForm from "./AgendaItemForm";
import NewObjectComponent from "../Generic/NewObjectComponent";

const NewAgendaItem = () => {
    const queryCache = useQueryCache();
    const history = useHistory();
    const onSuccess = (agendaItem) => {
        queryCache.setQueryData(['agendaitems', agendaItem.id], agendaItem)
        history.push(`/agendaitems/${agendaItem.id}`)
    }


    return <NewObjectComponent
        objectName='agendaItem'
        FormComponent={AgendaItemForm}
        createFunction={createAgendaitem}
        onSuccess={onSuccess}
    />

};

export default NewAgendaItem