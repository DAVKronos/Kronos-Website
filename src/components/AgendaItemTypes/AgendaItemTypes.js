import React from "react";
import {useQuery, useQueryCache} from "react-query";
import {Button, Table} from "react-bootstrap";
import {Link} from "react-router-dom";
import {useTranslation} from "react-i18next";
import {deleteAgendaItemType, getAgendaItemTypes} from "./queries";
import {Can} from "../../utils/auth-helper";

const AgendaItemTypes = () => {
    const {t} = useTranslation('generic');
    const queryCache = useQueryCache();
    const { isLoading, isError, data:agendaItemTypes, error } = useQuery('agendaItemTypes', getAgendaItemTypes)

    const onClickRemove = (id) => {
        deleteAgendaItemType(id).then(() => {
            queryCache.invalidateQueries('agendaItemTypes');
        })
    }


    return <React.Fragment>
        <h1>Agendaitem types</h1>
        <Table>
            <thead>
            <tr>
                <th colSpan={3}>
                    Naam
                </th>
            </tr>
            </thead>
            <tbody>
            {agendaItemTypes && agendaItemTypes.map(({id, name}) => {
                return (<tr key={id}>
                    <td>{name}</td>
                    <td>
                        <Can I={'update'} an={'Agendaitemtype'}>
                            <Button variant={'warning'} as={Link} to={`/agendaitemtypes/${id}/edit`}>{t('edit')}</Button>
                        </Can>
                    </td>
                    <td>
                        <Can I={'delete'} an={'Agendaitemtype'}>
                            <Button variant={'danger'} onClick={() => onClickRemove(id)}>{t('remove')}</Button>
                        </Can>
                    </td>
                </tr>);
            })}
            </tbody>
        </Table>
        <Can I={'create'} an={'Agendaitemtype'}>
            <Button as={Link} to={`/agendaitemtypes/new`}>{t('add')}</Button>
        </Can>
    </React.Fragment>;
};

export default AgendaItemTypes