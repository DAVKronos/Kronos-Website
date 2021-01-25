import React from "react";
import {useQuery, useQueryCache} from "react-query";
import DefaultSpinner from "../Generic/Spinner";
import {useHistory} from "react-router-dom";
import EditObjectComponent from "../Generic/EditObjectComponent";
import {getAgendaItemType, updateAgendaItemType} from "./queries";
import AgendaItemTypeForm from "./AgendaItemTypeForm";

const EditAgendaItemTypeWithData = (props) => {
    const id = props.match.params.id;
    const { isLoading, isError, data, error } = useQuery(['agendaitemtypes', id], getAgendaItemType)
    if (isLoading) {
        return <DefaultSpinner />;
    }
    return data && <EditAgendaItemType agendaItem={data} />
}

const EditAgendaItemType = ({agendaItem}) => {

    const queryCache = useQueryCache()
    const history = useHistory()
    const {id, created_at, updated_at, category, user_id, ...visibleFields} = agendaItem;

    const onSuccess = (savedAgendaItem) => {
        queryCache.setQueryData(['agendaitemtypes', savedAgendaItem.id], savedAgendaItem)
        history.push(`/agendaitemtypes/`)
    }

    return <EditObjectComponent
        id={id}
        existingObject={visibleFields}
        objectName='agendaItemType'
        updateFunction={updateAgendaItemType}
        onSuccess={onSuccess}
        FormComponent={AgendaItemTypeForm}
    />
}

export default EditAgendaItemTypeWithData