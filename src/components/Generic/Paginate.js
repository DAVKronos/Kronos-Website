import React, {useState} from 'react';
import {Row, Col, Pagination} from 'react-bootstrap';

const Paginate = ({data, Item, itemsPerPage = 12, colSize = {sm: 4, md: 4}}) => {
    let pageNumbers = [];
    const [currentPage, setCurrentPage] = useState(1);
    let pages = Math.ceil(data.length / itemsPerPage);
    for (let number = 1; number <= pages; number++) {
        pageNumbers.push(
            <Pagination.Item key={number} onClick={() => setCurrentPage(number)}
                             active={number === currentPage}>
                {number}
            </Pagination.Item>,
        );
    }

    let dataPage = data.slice((currentPage-1)*itemsPerPage, currentPage * itemsPerPage);

    return <React.Fragment>
        <Row>
            {dataPage && dataPage.map(item => {
                return <Col key={item.id} md={colSize.md} sm={colSize.sm}>
                    <Item item={item}/>
                </Col>;
            })}
        </Row>
        <Row className="row-margin">
            <Col>
                <Pagination>
                    <Pagination.Prev disabled={currentPage===1} onClick={() => setCurrentPage(currentPage - 1 )}/>
                    {pageNumbers}
                    <Pagination.Next disabled={currentPage === pages} onClick={() => setCurrentPage(currentPage + 1 )}/>
                </Pagination>
            </Col>
        </Row>
    </React.Fragment>
}

export default Paginate