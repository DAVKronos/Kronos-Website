import {useQuery} from "react-query";
import {getAgendaitemType} from "./queries";

const AgendaItemTypeName = ({id}) => {
    const { isLoading, isError, data, error } = useQuery(['agendaitemtypes', id], getAgendaitemType)
    const agendaItemType = data || null;
    return agendaItemType && agendaItemType.name
}


export {AgendaItemTypeName}