import React, {useState, useContext} from 'react';
import {Alert, Button, Form, NavDropdown, Image, Col} from 'react-bootstrap';
import {useTranslation} from "react-i18next";
import {login, logout} from '../../utils/auth-helper'
import { authContext } from '../../utils/AuthContext';
import {Can} from "../../utils/auth-helper";
import {BsPersonFill, BsBoxArrowRight, BsFillCloudFill, BsFillGearFill} from 'react-icons/bs';
import DefaultSpinner from "../Generic/Spinner";
import {NavLink, Link, useHistory} from "react-router-dom";



const LoginMenu = () => {
    const {t} = useTranslation('loginMenu');
    const [email, setEmail] = useState();
    const [password, setPassword] = useState();
    const [rememberMe, setRememberMe] = useState(true);
    const [loading, setLoading] = useState(false);
    const [incorrectCredentials, setIncorrectCredentials] = useState(false);
    const { setUserData } = useContext(authContext);
    const onFormSubmit = e => {
        e.preventDefault();
        setLoading(true);
        login(email, password, rememberMe).then((user) => {
            setLoading(false);
	    setIncorrectCredentials(false);
            setUserData(user);
        })
	.catch((err) => {
	    setLoading(false);
	    setIncorrectCredentials(true);
	});
    };

    if (loading) {
        return <DefaultSpinner/>;
    }

    return <Form className="form-padding login-menu" onSubmit={onFormSubmit}>
	       { incorrectCredentials &&
		 <Alert variant="danger">{t('incorrectCredentials')}</Alert>}
        <Form.Group controlId="formBasicEmail">
            <Form.Control type="email" placeholder={t('email')} onChange={e => {
                setEmail(e.target.value);
            }}/>
        </Form.Group>

        <Form.Group controlId="formBasicPassword">
            <Form.Control type="password" placeholder={t('password')} onChange={e => {
                setPassword(e.target.value);
            }}/>
        </Form.Group>
        <Form.Group controlId="formBasicCheckbox">
            <Form.Check type="checkbox" label={t('rememberMe')} checked={rememberMe} onChange={() => {
                setRememberMe(!rememberMe);
            }}/>
        </Form.Group>
             
        <Form.Row>
            <Col>
                <Button variant="primary" type='submit' >
                    {t('login')}
                </Button>
            </Col>
        </Form.Row>
        <Form.Row>
            <Col>
            <Link to="/users/forgot_password">{t('forgotPassword')}</Link>
            </Col>
        </Form.Row>
    </Form>
}

const LoggedInMenu = ({user}) => {
    const history = useHistory();
    let firstName = user.name.split(' ')[0]
    const {t} = useTranslation('loginMenu');
    const { setUserData } = useContext(authContext);
    const onClickLogout = () => {
        logout().then(() => {
            setUserData(null);
	    history.push("/");
        });
    }
    return <React.Fragment>
        <div className="logged-in-menu">
            <Image src={user.avatar_url_thumb} roundedCircle />
            <h3>{firstName}</h3>
        </div>

        <NavDropdown.Item as={NavLink} to={`/users/${user.id}`}><BsPersonFill/> {firstName}'s stek</NavDropdown.Item>
        <NavDropdown.Item active={false} target={'_blank'} href={'https://cloud.kronos.nl'}><BsFillCloudFill/> {t('kronosCloud')}</NavDropdown.Item>
        <Can I={'manage'} this='all'>
        <NavDropdown.Item as={NavLink} to='/admin'><BsFillGearFill/> {t('admin')}</NavDropdown.Item>
        </Can>
        <NavDropdown.Item onClick={onClickLogout}><BsBoxArrowRight/> {t('logout')}</NavDropdown.Item>
    </React.Fragment>

}

const UserMenu = () => {
    const { user } = useContext(authContext);


    if (user) {
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
