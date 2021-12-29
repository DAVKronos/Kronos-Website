import React from 'react';
import {updateAgendaitem, getAgendaitem} from "./queries";
import {useQuery, useQueryCache} from "react-query";
import {useHistory} from "react-router-dom";
import DefaultSpinner from "../Generic/Spinner";
import AgendaItemForm from "./AgendaItemForm";
import EditObjectComponent from "../Generic/EditObjectComponent";

const EditAgendaItemWithData = (props) => {
    const id = parseInt(props.match.params.id);
    const { isLoading, isError, data, error } = useQuery(['agendaitems', id], getAgendaitem)
    if (isLoading) {
        return <DefaultSpinner />;
    }
    return data && <EditAgendaItem agendaItem={data} />
}

const EditAgendaItem = ({agendaItem}) => {

    const queryCache = useQueryCache()
    const history = useHistory()
    const {id, created_at, updated_at, category, user_id, ...visibleFields} = agendaItem;

    const onSuccess = (savedAgendaItem) => {
        queryCache.setQueryData(['agendaitems', savedAgendaItem.id], savedAgendaItem)
        history.push(`/agendaitems/${savedAgendaItem.id}`)
    }

    return <EditObjectComponent
        id={id}
        existingObject={visibleFields}
        objectName='agendaItem'
        updateFunction={updateAgendaitem}
        onSuccess={onSuccess}
        FormComponent={AgendaItemForm}
    />
}

export default EditAgendaItemWithData