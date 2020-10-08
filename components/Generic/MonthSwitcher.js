import React from 'react';
import {Button, Form, FormControl, Nav} from "react-bootstrap";
import format from "../../utils/date-format";


const MonthSwitcher = ({date, searchMonth, searchYear, onChangeDate, onChangeSearchMonth, onChangeSearchYear, onClickSearch}) => {
    let month = date.getMonth();
    let year = date.getFullYear();

    let searchYearValue = searchYear !== null ? searchYear : year;
    let searchMonthValue = searchMonth !== null ?  searchMonth : month + 1;
    let prev = new Date(year, month - 1);
    let next = new Date(year, month + 1);
    return <Nav variant="tabs">
        <Nav.Item>
            <Nav.Link
                onClick={() => onChangeDate(prev)}>{format(prev, 'MMM yyyy')}</Nav.Link>
        </Nav.Item>
        <Nav.Item>
            <Nav.Link active>{format(date, 'MMM yyyy')}</Nav.Link>
        </Nav.Item>
        <Nav.Item>
            <Nav.Link
                onClick={() => onChangeDate(next)}>{format(next, 'MMM yyyy')}</Nav.Link>
        </Nav.Item>
        <Nav.Item>
            <Form inline>
                <FormControl style={{width: 50}} type="text" placeholder="M" value={searchMonthValue} onChange={onChangeSearchMonth} className="mr-sm-1" />
                <FormControl style={{width: 100}} type="text" placeholder="Y" value={searchYearValue} onChange={onChangeSearchYear} className="mr-sm-1" />
                <Button variant="outline-success" onClick={onClickSearch}>Search</Button>
            </Form>
        </Nav.Item>
    </Nav>
}

export default MonthSwitcher