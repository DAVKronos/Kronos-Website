import React from 'react';
import {Table} from "react-bootstrap";
import {Link} from 'react-router-dom';
import {useQuery} from "react-query";
import {getCommissions} from "./queries";

function Commissions(props) {

    const { isLoading, isError, data, error } = useQuery('commissions', getCommissions)

    const commissions = data;

    return <React.Fragment>
        <h1>Commissies van Kronos</h1>
        <p className={"lead"}>Onderstaand treft u een overzicht aan van de huidige commissies van Kronos.</p>
        <Table striped>
            <thead>
            <tr>
                <th>
                    Naam
                </th>
            </tr>
            </thead>
            <tbody>
            {commissions && commissions.map(commission => {
                return <tr key={commission.id}>
                    <td><Link to={`/commissions/${commission.id}`}>{commission.name}</Link></td>
                </tr>;
            })}
            </tbody>
        </Table>
    </React.Fragment>;
}

export default Commissions