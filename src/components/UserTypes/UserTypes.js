import React from "react";
import {useQuery, useQueryCache} from "react-query";
import {getAgendaItemTypes} from "../AgendaItemTypes/queries";

const UserTypes = () => {
    const { isLoading, isError, data:agendaItemTypes, error } = useQuery('agendaItemTypes', getAgendaItemTypes)
    return <React.Fragment>
        hoi
    </React.Fragment>
}

export default UserTypes