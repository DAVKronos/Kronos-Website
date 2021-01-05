import React from "react";
import {Col, Row} from 'react-bootstrap';
import {getAPIHostUrl} from "../../utils/rest-helper";
import {format} from '../../utils/date-format';
import {useQuery} from "react-query";
import {getUsers} from "./queries";
import DefaultSpinner from "../Generic/Spinner";

const Users = () => {
    const { isLoading, data} = useQuery('users', getUsers);
    if (isLoading) {
        return <DefaultSpinner />;
    }

    return data.map((user) => {
        return <p>{user.name}</p>
    });
}

export default Users;