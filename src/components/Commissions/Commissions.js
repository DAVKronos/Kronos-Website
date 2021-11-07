import React from 'react';
import {Table} from "react-bootstrap";
import {Link} from 'react-router-dom';
import {useQuery} from "react-query";
import {useTranslation} from "react-i18next";
import {getCommissions} from "./queries";

function Commissions(props) {

    const { isLoading, isError, data, error } = useQuery('commissions', getCommissions)

    const commissions = data;
    const {t,i18n} = useTranslation('committeePage');
    const lang = i18n.language;
    return <React.Fragment>
        <h1>{t('headerText')}</h1>
        <p className={"lead"}>{t('pageDescription')}</p>
        <Table striped>
            <thead>
            <tr>
                <th>
                    {t('name')}
                </th>
            </tr>
            </thead>
            <tbody>
            {commissions && commissions.map(commission => {
                name = lang === 'nl' ? commission.name : commission.name_en;
                return <tr key={commission.id}>
                    <td><Link to={`/commissions/${commission.id}`}>{name}</Link></td>
                </tr>;
            })}
            </tbody>
        </Table>
    </React.Fragment>;
}

export default Commissions