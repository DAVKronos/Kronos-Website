import React from 'react';
import {Navbar, Nav, NavDropdown} from "react-bootstrap";
import {NavLink} from 'react-router-dom';
import {PagesCollection} from "../../utils/rest-helper";
import withData from "../../utils/withData";
import {authContext} from '../../utils/AuthContext';
import UserMenu from "./LoginMenu";
import PrivateComponent from "../PrivateComponent";

class NavBar extends React.Component {
    getPagesForMenu(title) {
        let pages = this.props.data || [];
        return pages.filter((page) => {
            return page.menu === title;
        })
    }

    getPageLinksForMenu(title) {
        return this.getPagesForMenu(title).map(page => {
            return <NavDropdown.Item key={page.pagetag} as={NavLink} to={`/${page.pagetag}`}>{page.pagetag}</NavDropdown.Item>
        })
    }

    getHighlightPages() {
        let pages = this.props.data || [];
        return pages.filter((page) => {
            return page.highlight;
        }).map(page => {
            return <Nav.Link className='highlight' key={page.pagetag} as={NavLink} to={`/${page.pagetag}`}>{page.pagetag}</Nav.Link>;
        })
    }

    render() {
        // TODO Add highlight pages
        return <Navbar id="navbar-kronos" expand="lg">
            <Navbar.Toggle aria-controls="basic-navbar-nav"/>
            <Navbar.Collapse id="basic-navbar-nav">
                <Nav className="mr-auto">
                    <Nav.Link as={NavLink} to="/" exact>Home</Nav.Link>
                    <NavDropdown title="Vereniging" id="basic-nav-dropdown">
                        <NavDropdown.Item as={NavLink} to="/commissions">Commissies</NavDropdown.Item>
                        {this.getPageLinksForMenu('Vereniging')}
                    </NavDropdown>
                    <NavDropdown title="Trainingen" id="basic-nav-dropdown">
                        {this.getPageLinksForMenu('Trainingen')}
                    </NavDropdown>
                    <NavDropdown title="Wedstrijden" id="basic-nav-dropdown">
                        {this.getPageLinksForMenu('Wedstrijden')}
                    </NavDropdown>
                    <Nav.Link as={NavLink} to="/agendaitems">Agenda</Nav.Link>
                    <Nav.Link as={NavLink} to="/results">Uitslagen</Nav.Link>
                    <Nav.Link as={NavLink} to="/photoalbums">Foto's</Nav.Link>
                    <Nav.Link as={NavLink} to="/contact">Contact</Nav.Link>
                    {this.getHighlightPages()}
                </Nav>
                <Nav className="justify-content-end">
                    <PrivateComponent>
                        <Nav.Link as={NavLink} to="/leden">Leden</Nav.Link>
                    </PrivateComponent>
                    <UserMenu/>
                </Nav>

            </Navbar.Collapse>
        </Navbar>
    }
}
NavBar.contextType = authContext
export default withData(NavBar, () => PagesCollection.getAll())