import withData from "../../utils/withData";
import {AgendaItemTypesCollection} from "../../utils/rest-helper";

const AgendaItemTypeName = ({data}) => {
    const agendaItemType = data || null;
    return agendaItemType && agendaItemType.name
}

const AgendaItemTypeNameData = withData(AgendaItemTypeName, (props) => AgendaItemTypesCollection.get(props.id));


export {AgendaItemTypeNameData as AgendaItemTypeName}