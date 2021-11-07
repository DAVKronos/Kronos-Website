import {useQuery} from "react-query";
import {useTranslation} from "react-i18next";
import {getAgendaitemType} from "./queries";

const AgendaItemTypeName = ({id}) => {
    const {i18n} = useTranslation();
    const lang = i18n.language;
    const { isLoading, isError, data, error } = useQuery(['agendaitemtypes', id], getAgendaitemType)
    const agendaItemType = data || null;
    return agendaItemType && (lang == 'en' ? agendaItemType.name_en : agendaItemType.name);
}


export {AgendaItemTypeName}