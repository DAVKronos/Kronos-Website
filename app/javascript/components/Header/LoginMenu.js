import React, {useState, useContext} from 'react';
import {Button, Form, Nav, NavDropdown, Row, Col, Image} from 'react-bootstrap';
import {login, logout} from '../../utils/auth-helper'
import { authContext } from '../../utils/AuthContext';
import {BsPersonFill} from 'react-icons/bs';
import DefaultSpinner from "../Spinner";

const LoginMenu = () => {
    const [email, setEmail] = useState();
    const [password, setPassword] = useState();
    const [loading, setLoading] = useState(false);
    const { setAuthData } = useContext(authContext);
    const onFormSubmit = e => {
        e.preventDefault();
        setLoading(true);
        login(email, password).then((data) => {
            setLoading(false);
            setAuthData(data);
        });
    };

    if (loading) {
        return <DefaultSpinner/>;
    }

    return <Form style={{padding: 7}} onSubmit={onFormSubmit}>
        <Form.Group controlId="formBasicEmail">
            <Form.Control type="email" placeholder="Emailadres" onChange={e => {
                setEmail(e.target.value);
            }}/>
        </Form.Group>

        <Form.Group controlId="formBasicPassword">
            <Form.Control type="password" placeholder="Wachtwoord" onChange={e => {
                setPassword(e.target.value);
            }}/>
        </Form.Group>
        <Form.Group controlId="formBasicCheckbox">
            <Form.Check type="checkbox" label="Onthoud mij"/>
        </Form.Group>
        <Button variant="primary" type='submit' >
            Inloggen
        </Button>
    </Form>
}

const LoggedInMenu = ({user}) => {
    let firstName = user.name.split(' ')[0]
    const { setAuthData } = useContext(authContext);
    const onClickLogout = () => {
        logout().then(() => {
            setAuthData(null);
        });
    }
    return <React.Fragment>
        <div style={{'display': 'flexbox', 'justifyContent': 'center'}}>
            <Image src="" roundedCircle />
            <h3 style={{textAlign: 'center'}}>{firstName}</h3>
        </div>

        <NavDropdown.Item >{firstName}'s stek</NavDropdown.Item>
        <NavDropdown.Item >Kronos cloud</NavDropdown.Item>
        <NavDropdown.Item onClick={onClickLogout}>Logout</NavDropdown.Item>
    </React.Fragment>

}

const UserMenu = () => {
    const { auth } = useContext(authContext);
    const user = auth.data;

    if (user) {
        console.log(user);
        let firstName = user.name.split(' ')[0];
        let dropdownTitle = <React.Fragment><BsPersonFill/>{firstName}</React.Fragment>
        return <NavDropdown title={dropdownTitle} id="basic-nav-dropdown" alignRight>
            <LoggedInMenu user={user}/>
        </NavDropdown>;
    }
    return <NavDropdown title="Login" id="basic-nav-dropdown" alignRight>
        <LoginMenu/>
    </NavDropdown>
}


export default UserMenu