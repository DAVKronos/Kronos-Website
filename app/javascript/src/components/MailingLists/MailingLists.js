import React, {useState} from 'react';
import {useQuery, useQueryCache} from "react-query";
import {Table, Button} from 'react-bootstrap';
import { getMailingLists, removeMailingList } from './queries';
import {Link} from 'react-router-dom';
import {Can} from '../../utils/auth-helper';
import {useTranslation} from "react-i18next";
import DefaultSpinner from '../Generic/Spinner';
import { getCommissions } from '../Commissions/queries';

const MailingLists = () => {
    const { isLoading, isError, data: mailingLists, error } = useQuery('mailinglists', getMailingLists);
    const {isLoading: commissionsLoading, data: commissions} = useQuery('commissions', getCommissions);
    const [removing, setRemoving] = useState(null);
    const {t} = useTranslation('generic');
    const mailingListCount = mailingLists ? mailingLists.length : 0;
    const queryCache = useQueryCache();
    return <React.Fragment>
    <h1>{t('models:modelNames.mailingList', {count: mailingListCount})}</h1>
    <Table striped>
        <thead>
        <tr>
            <th>
            {t('models:mailingList.name')}
            </th>
            <th>
            {t('models:mailingList.description')}
            </th>
            <th>
            {t('models:mailingList.local_part')}
            </th>
            <th>
            {t('models:mailingList.commission_id')}
            </th>
            <th colSpan={2}>
                Acties
            </th>
        </tr>
        </thead>
        <tbody>
            
        {mailingLists && mailingLists.map(mailingList => {
            const onClickRemove = () => {
                setRemoving(mailingList.id);
                removeMailingList(mailingList.id).then(() => {
                    queryCache.invalidateQueries(['mailinglists']);
                    setRemoving(null);
                })
            }
            const removingThis = removing == mailingList.id
            let commissionText = 'Geen'
            if (mailingList.commission_id) {
                if (commissionsLoading){
                    commissionText = <DefaultSpinner inline size='sm'/>;
                } else {
                    const commission = commissions.find((v) => v.id == mailingList.commission_id);
                    commissionText = commission && commission.name;
                }
            }
            return <tr key={mailingList.id}>
                <td>{mailingList.name}</td>
                <td>{mailingList.description}</td>
                <td>{mailingList.local_part}@kronos.nl</td>
                <td>{commissionText}</td>
                <td><Button variant='warning' disabled={removingThis} size='sm' as={Link} to={`/admin/mailinglists/${mailingList.id}/edit`}>Bewerk</Button></td>
                <td><Button variant='danger' disabled={removingThis} size='sm' onClick={onClickRemove}>{removingThis ? <DefaultSpinner inline size='sm'/> : 'Verwijder'}</Button></td>
            </tr>
        })}
        </tbody>
    </Table>
    {isLoading && <DefaultSpinner/>}
    <Can I='create' a={'Mailinglist'}>
        <Button as={Link} to='/admin/mailinglists/new'>{t('addModel', {model: t('models:modelNames.mailingList', {count: 0})})}</Button>
    </Can>
</React.Fragment>;
}

export default MailingLists