import React from 'react';
import {useQuery} from "react-query";
import { getUnapprovedNewsItems } from './queries';
import {Table} from 'react-bootstrap'
import { Link } from "react-router-dom";

const ApproveNews = () => {
    const { isLoading, isError, data: newsitems, error } = useQuery('unapproved-newsitems', getUnapprovedNewsItems)
    return <React.Fragment>
    <h1>Nieuwsitems goedkeuren</h1>
    <Table striped>
        <thead>
        <tr>
            <th>
                Titel
            </th>
            <th>
                Auteur
            </th>
            <th>
                Laatst gewijzigd op
            </th>
            <th>
                
            </th>
        </tr>
        </thead>
        <tbody>
        {newsitems && newsitems.map(newsitem => {
            return <tr key={newsitem.id}>
                <td>{newsitem.title}</td>
                <td>{newsitem.user.name}</td>
                <td>{newsitem.updated_at}</td>
                <td><Link to={`/newsitems/${newsitem.id}`}>Bekijken</Link></td>
            </tr>;
        })}
        </tbody>
    </Table>
</React.Fragment>;
}

export default ApproveNews