import React from 'react';
import {Table} from 'react-bootstrap';
import {useQuery} from "react-query";
import {getCommission} from "./queries";
import DefaultSpinner from "../Generic/Spinner";

function Commission(props) {
    const id = parseInt(props.match.params.id);
    const { isLoading, isError, data, error } = useQuery(['commissions', id], getCommission)

    if (isLoading) {
        return <DefaultSpinner />;
    }

    const commission = data;
    if (!commission) {
        return <h1>Commission not found</h1>
    }


    return <React.Fragment>
        <h1>{commission.name}</h1>
        <p className={"lead"}>{commission.description}</p>
        <Table striped>
            <thead>
            <tr>
                <th>
                    Naam
                </th>
                <th>
                    Functie
                </th>
            </tr>
            </thead>
            <tbody>
            {commission.commission_memberships && commission.commission_memberships.map(membership => {
                let name = membership.user && membership.user.name;
                return <tr key={membership.id}>
                    <td>{name}</td>
                    <td>{membership.function}</td>
                </tr>
            })}
            </tbody>
        </Table>
    </React.Fragment>;
}

export default Commission