import React from "react";
import {Col, Row} from 'react-bootstrap';
import {getAPIHostUrl} from "../../utils/rest-helper";
import format from '../../utils/date-format';
import {useQuery} from "react-query";
import {getUser} from "./queries";

const User = (props) => {
    const id = props.match.params.id
    const { isLoading, data:user} = useQuery(['users',id], getUser);
    if (user){
        return <p>{user.name}</p>;
    }
    return null;
}

export default User;