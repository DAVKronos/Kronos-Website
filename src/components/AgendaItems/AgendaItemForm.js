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
    required: true
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
    type: "reference"
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
    const { auth } = useContext(authContext);
    const {data: agendaItemTypes} = useQuery(['agendaitemtypes'], getAgendaitemTypes)
    const { data: commissions  } = useQuery(['commissions', auth.data.id], getCommissionForUser)
    return <Form>
        {agendaItemFields.map((field) => {
            let items = field.name === 'agendaitemtype_id' ? agendaItemTypes : field.name === 'commission_id' ? commissions : [];
            if (!field.conditionField || values[field.conditionField])
            return <FormField
                modelName={'agendaitem'}
                fieldName={field.name}
                value={values[field.name]}
                setValue={(v) => setValue(field.name, v)}
                type={field.type}
                items={items}
                required={field.required}
            />
        })}
        {children}
    </Form>
}

export default AgendaItemForm