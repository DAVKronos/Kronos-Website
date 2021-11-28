import React,{useState} from "react";
import {Link} from "react-router-dom";
import {Nav, Col, Row, Image} from 'react-bootstrap';
import {getAPIHostUrl} from "../../utils/rest-helper";
import {format} from '../../utils/date-format';
import {useQuery} from "react-query";
import {getUsers,getUserTypes} from "./queries";
import {useTranslation} from "react-i18next";
import DefaultSpinner from "../Generic/Spinner";

function UserTypesFilter({filter, onChangeFilter}){
    const {t} = useTranslation('generic');
    const { isLoading, isError, data, error } = useQuery('usertypes', getUserTypes)
    return <Nav variant="pills">
        <Nav.Item key='all'>
            <Nav.Link active={filter == null} onClick={() => onChangeFilter(null)}>
                {t('allItems')}
            </Nav.Link>
        </Nav.Item>
        {data && data.map(userType => {
            return <Nav.Item key={userType.id}>
                <Nav.Link
                    active={filter === userType.id}
                    onClick={() => onChangeFilter(userType.id)}>
                    {userType.name}
                </Nav.Link>
            </Nav.Item>;
        })}
    </Nav>
}

function LetterFilter({filter, onChangeFilter,alpha_params}){
    return <Nav variant="tabs">
        {alpha_params && alpha_params.map(letter => {
            return <Nav.Item key = {alpha_params.indexOf(letter)}>
                <Nav.Link
                    active={filter === letter}
                    onClick={() => onChangeFilter(letter)}>
                    {letter}
                </Nav.Link>
            </Nav.Item>
        })}
    </Nav>
}

const Users = () => {

    const {t,i18n} = useTranslation('userpage');
    const lang = i18n.language;
    const [filter, setFilter] = useState(null);
    const [lfilter, setlFilter] = useState('a');

    let { isLoading, isError, data:users} = useQuery('users', getUsers);
    if (isLoading) {
        return <DefaultSpinner />;
    }

    let names = users.map(item => item.name);
    let alpha_params = names.map(name =>name.charAt(0).toUpperCase());
    alpha_params = [... new Set(alpha_params)].sort();

    const onChangeFilter = (newFilter) => {
        if (filter !== newFilter) {
            setFilter(newFilter);
        }
    }
    const onChangeLfilter = (newFilter) => {
        if (lfilter !== newFilter) {
            setlFilter(newFilter);
        }
    }

    if (users && filter) {
        users = users.filter(user => user.user_type_id === filter)
    }
    if (users && lfilter) {
        users = users.filter((user) => user.name.startsWith(lfilter))
    }

    return (<React.Fragment>
        <h1>{t('kronauts')}</h1>
        <Row className="row-margin">
            <Col md={12}>
                <UserTypesFilter filter={filter} onChangeFilter={onChangeFilter}/>
            </Col>
        </Row>
        <Row className="row-margin">
            <Col md={12}>
                <LetterFilter filter={lfilter} onChangeFilter={onChangeLfilter} alpha_params ={alpha_params}/>
            </Col>
        </Row>
        <Row className="row-margin">
            <Col md={12}>
                {isLoading && <DefaultSpinner/>}
                {users && users.map(user => {
                    return <Link key={user.id} to={`/users/${user.id}`} className='user'>
                        <Col sm={6} md={3}>
                            <div className='thumbnail'>
                                <figure>
                                    <Image src={user.avatar_url_pass} />
                                    <figcaption>{user.name}</figcaption>
                                </figure>
                            </div>
                        </Col>
                    </Link>
                })}
            </Col>
        </Row>
    </React.Fragment>);

}

export default Users;