import {useQuery} from "react-query";
import {getAgendaitemTypes, getCommissionForUser} from "./queries";
import React, {useContext} from "react";
import FormField from "../Generic/FormField";
import {authContext} from "../../utils/AuthContext";
import {Form} from "react-bootstrap";


const agendaItemFields = [{
    name: 'name',
    type: 'text',
    required: true
}, {
    name: "name_en",
    type: 'text',
    required: true
}, {

    name: "agendaitemtype_id",
    type: 'reference',
    required: true,
    itemQuery: [['agendaitemtypes'], getAgendaitemTypes]
}, {
    name: "date",
    type: 'datetime',
    required: true
}, {
    name: "intern",
    type: 'boolean'
}, {
    name: "description",
    type: 'textarea'
}, {
    name: "description_en",
    type: 'textarea'
}, {
    name: "location",
    type: 'text'
}, {
    name: "url",
    type: 'text'
}, {
    name: "commission_id",
    type: "reference",
    itemQuery: userId => [['users',userId, 'commissions'], getCommissionForUser, {enabled: !!userId}]
}, {
    name: "subscribe",
    type: 'boolean'
}, {
    name: "subscriptiondeadline",
    type: 'datetime',
    conditionField: 'subscribe'
}, {
    name: "maxsubscription",
    type: 'number',
    conditionField: 'subscribe'
}]

// TODO: make required do something (with react-hook-form)
const AgendaItemForm = ({values, setValue, children }) => {
    const { user } = useContext(authContext);
    const userId = user && user.id;
    return <Form>
        {agendaItemFields.map(({name, type, required, itemQuery, conditionField, ...otherProps}) => {
            let newItemQuery = name === 'commission_id' ? itemQuery(userId) : itemQuery;
            if (!conditionField || values[conditionField])
            return <FormField
                {...otherProps}
                key={name}
                modelName={'agendaitem'}
                fieldName={name}
                value={values[name]}
                setValue={(v) => setValue(name, v)}
                type={type}
                required={required}
                itemQuery={newItemQuery}
            />
        })}
        {children}
    </Form>
}

export default AgendaItemForm