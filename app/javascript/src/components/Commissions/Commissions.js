import React from 'react';
import {Table} from "react-bootstrap";
import {Link} from 'react-router-dom';
import {useQuery} from "react-query";
import {useTranslation} from "react-i18next";
import {getCommissions} from "./queries";
import MultiLanguageText from '../Generic/MultiLanguageText';

function Commissions(props) {

    const { isLoading, isError, data, error } = useQuery('commissions', getCommissions)

    const commissions = data;
    const {t} = useTranslation('committeePage');
    
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
                return <tr key={commission.id}>
                    <td><Link to={`/commissions/${commission.id}`}>
                        <MultiLanguageText nl={commission.name} en={commission.name_en} />
                        </Link></td>
                </tr>;
            })}
            </tbody>
        </Table>
    </React.Fragment>;
}

export default Commissions