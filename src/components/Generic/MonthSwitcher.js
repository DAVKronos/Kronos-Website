import React, {useState} from 'react';
import {useHistory} from 'react-router-dom';
import {Button, Form, FormControl, Nav} from "react-bootstrap";
import {format} from "../../utils/date-format";


const MonthSwitcher = ({date}) => {
    let history = useHistory();
    const [searchMonth, setSearchMonth] = useState("");
    const [searchYear, setSearchYear] = useState("");
    let month = date.getMonth();
    let year = date.getFullYear();
    const changeDate = (date) => {
        let newYear = date.getFullYear();
        let newMonth = date.getMonth() + 1;
        history.push({
            pathname: history.location.pathname,
            search: `?year=${newYear}&month=${newMonth}`
        })
    }

    const onClickSearch = (event) => {
        event.preventDefault();
        if (searchYear && searchMonth) {
            changeDate(new Date(searchYear, searchMonth - 1));
            setSearchMonth("");
            setSearchYear("");
        }
    }
    let prev = new Date(year, month - 1);
    let next = new Date(year, month + 1);
    return <Nav variant="tabs">
        <Nav.Item>
            <Nav.Link
                onClick={() => changeDate(prev)}>{format(prev, 'MMM yyyy')}</Nav.Link>
        </Nav.Item>
        <Nav.Item>
            <Nav.Link active>{format(date, 'MMM yyyy')}</Nav.Link>
        </Nav.Item>
        <Nav.Item>
            <Nav.Link
                onClick={() => changeDate(next)}>{format(next, 'MMM yyyy')}</Nav.Link>
        </Nav.Item>
        <Nav.Item>
            <Form inline onSubmit={onClickSearch}>
                <FormControl style={{width: 50}} type="text" placeholder="MM" value={searchMonth} onChange={(event) => setSearchMonth(event.target.value)} className="mr-sm-1" />
                <FormControl style={{width: 100}} type="text" placeholder="YYYY" value={searchYear} onChange={(event) => setSearchYear(event.target.value)} className="mr-sm-1" />
                <Button variant="outline-success" type="submit">Search</Button>
            </Form>
        </Nav.Item>
    </Nav>
}

export default MonthSwitcher