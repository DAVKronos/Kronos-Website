import React from 'react'
import {useQuery, useQueryCache} from "react-query";
import {Table} from 'react-bootstrap';
import {getPages} from '../Pages/queries';
import {Link} from 'react-router-dom';
import {BsFillXCircleFill, BsFillCheckCircleFill} from 'react-icons/bs';

const Pages = () => {
    const { isLoading, isError, data: pages, error } = useQuery('pages', getPages);
    const queryCache = useQueryCache();
    return <React.Fragment>
    <h1>Informatie pagina's</h1>
    <Table striped>
        <thead>
        <tr>
            <th>
                Pagina tag
            </th>
            <th>
                Pagina tag (en)
            </th>
            <th>
                Menu
            </th>
            <th>
                Public
            </th>
            <th>
                Highlight
            </th>
            <th colSpan={3}>
                Acties
            </th>
        </tr>
        </thead>
        <tbody>
        {pages && pages.map(page => {
            const onClickRemove = () => {
                removePage(page.id).then(() => {
                    queryCache.invalidateQueries(['pages']);
                })
            }

            return <tr key={page.id}>
                <td>{page.pagetag}</td>
                <td>{page.pagetag_en}</td>
                <td>{page.menu}</td>
                <td>{page.public ? <BsFillCheckCircleFill/> : <BsFillXCircleFill/>}</td>
                <td>{page.highlight ? <BsFillCheckCircleFill/> : <BsFillXCircleFill/>}</td>
                <td><Link to={`/pages/${page.id}`}>Bekijk</Link></td>
                <td><Link to={`/pages/${page.id}/edit`}>Bewerk</Link></td>
                <td><a onClick={onClickRemove} href="">Verwijder</a></td>
            </tr>
        })}
        </tbody>
    </Table>
</React.Fragment>;
}

export default Pages;