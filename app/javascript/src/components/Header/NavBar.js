import React from 'react';
import {Nav, Navbar, NavDropdown} from "react-bootstrap";
import {NavLink} from 'react-router-dom';
import UserMenu from "./LoginMenu";
import PrivateComponent from "../PrivateComponent";
import {useQuery} from "react-query";
import {getPages} from "./queries";
import LanguageSwitch from "./LanguageSwitch";
import {useTranslation} from "react-i18next";

function getPagesForMenu(pages, title) {
    return pages.filter((page) => {
        return page.menu === title;
    })
}

function getPageLinksForMenu(pages, title) {
    return getPagesForMenu(pages, title).map(page => {
        return <NavDropdown.Item key={page.pagetag} as={NavLink} to={`/${page.pagetag}`}>{page.pagetag}</NavDropdown.Item>
    })
}

function getHighlightPages(pages) {
    return pages.filter((page) => {
        return page.highlight;
    }).map(page => {
        return <Nav.Link className='highlight' key={page.pagetag} as={NavLink} to={`/${page.pagetag}`}>{page.pagetag}</Nav.Link>;
    })
}

const NavBar =  () => {
    const { isLoading, isError, data } = useQuery('pages', getPages);
    const { t } = useTranslation('navigation');
    const pages = data || [];
    return <Navbar id="navbar-kronos" expand="lg">
        <Navbar.Toggle aria-controls="basic-navbar-nav"/>
        <Navbar.Collapse id="basic-navbar-nav">
            <Nav className="mr-auto">
                <Nav.Link as={NavLink} to="/" exact>Home</Nav.Link>
                <NavDropdown title={t('association')} id="basic-nav-dropdown">
                    <NavDropdown.Item as={NavLink} to="/commissions">Commissies</NavDropdown.Item>
                    {getPageLinksForMenu(pages,'Vereniging')}
                </NavDropdown>
                <NavDropdown title={t('trainings')} id="basic-nav-dropdown">
                    {getPageLinksForMenu(pages,'Trainingen')}
                </NavDropdown>
                <NavDropdown title={t('matches')} id="basic-nav-dropdown">
                    {getPageLinksForMenu(pages, 'Wedstrijden')}
                </NavDropdown>
                <Nav.Link as={NavLink} to="/agendaitems">{t('agenda')}</Nav.Link>
                <Nav.Link as={NavLink} to="/results">{t('results')}</Nav.Link>
                <Nav.Link as={NavLink} to="/photoalbums">{t('photos')}</Nav.Link>
                <Nav.Link as={NavLink} to="/contact">{t('contact')}</Nav.Link>
                {getHighlightPages(pages)}
            </Nav>
            <Nav className="justify-content-end">
                <LanguageSwitch />
                <PrivateComponent>
                    <Nav.Link as={NavLink} to="/users">Leden</Nav.Link>
                </PrivateComponent>
                <UserMenu/>
            </Nav>
        </Navbar.Collapse>
    </Navbar>
};

export default NavBar