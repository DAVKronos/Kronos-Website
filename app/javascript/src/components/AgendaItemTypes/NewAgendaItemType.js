import React from "react";
import NewObjectComponent from "../Generic/NewObjectComponent";
import {useQueryCache} from "react-query";
import {useHistory} from "react-router-dom";
import {createAgendaItemType} from "./queries";
import AgendaItemTypeForm from "./AgendaItemTypeForm";

const NewAgendaItemType = () => {
    const queryCache = useQueryCache();
    const history = useHistory();

    const onSuccess = (agendaItemType) => {
        queryCache.setQueryData(['agendaitemtype', agendaItemType.id], agendaItemType)
        history.push(`/agendaitemtypes/`)
    }


    return <NewObjectComponent
        objectName={'agendaItemType'}
        createFunction={createAgendaItemType}
        FormComponent={AgendaItemTypeForm}
        onSuccess={onSuccess}
    /> ;
}

export default NewAgendaItemType