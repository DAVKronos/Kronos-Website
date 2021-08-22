import React,{useState} from "react";
import {Nav, Col, Row} from 'react-bootstrap';
import {getAPIHostUrl} from "../../utils/rest-helper";
import {format} from '../../utils/date-format';
import {useQuery} from "react-query";
import {getUsers,getUserTypes} from "./queries";
import {useTranslation} from "react-i18next";
import DefaultSpinner from "../Generic/Spinner";
import {getAgendaitemTypes} from "../AgendaItems/queries";

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

const Users = () => {
    const { isLoading, data} = useQuery('users', getUsers);
    const { t } = useTranslation('userpage');
    const [filter, setFilter] = useState(null);

    if (isLoading) {
        return <DefaultSpinner />;
    }
    const onChangeFilter = (newFilter) => {
        if (filter !== newFilter) {
            setFilter(newFilter);
        }
    }

    return (<React.Fragment>
        <h1>{t('kronauts')}</h1>
        <Row className="row-margin">
            <Col md={12}>
                <UserTypesFilter filter={filter} onChangeFilter={onChangeFilter}/>
            </Col>
        </Row>
    </React.Fragment>);

}

export default Users;