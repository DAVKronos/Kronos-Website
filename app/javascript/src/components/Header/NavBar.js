import React, { useState } from 'react'
import { Nav, Navbar, NavDropdown, Container } from 'react-bootstrap'
import { NavLink } from 'react-router-dom'
import UserMenu from './LoginMenu'
import { useQuery } from 'react-query'
import { getPages } from './queries'
import { useTranslation } from 'react-i18next'
import { Can } from '../../utils/auth-helper'
import LanguageSwitch from './LanguageSwitch'
import './Header.scss'

function getPagesForMenu(pages, title) {
  return pages.filter((page) => {
    return page.menu === title
  })
}

function getPageLinksForMenu(pages, title) {
  return getPagesForMenu(pages, title).map(page => {
    return <NavDropdown.Item key={page.pagetag} as={NavLink} to={`/${page.pagetag}`} href={`/${page.pagetag}`}>{page.pagetag}</NavDropdown.Item>
  })
}

function getHighlightPages(pages) {
  return pages.filter((page) => {
    return page.highlight
  }).map(page => {
    return <Nav.Link className='highlight' key={page.pagetag} as={NavLink} to={`/${page.pagetag}`} href={`/${page.pagetag}`}>{page.pagetag}</Nav.Link>
  })
}

const NavBar = () => {
  const { isLoading, isError, data } = useQuery('pages', getPages)
  const { t } = useTranslation('navigation')
  const pages = data || []
  return (
    <Navbar id='navbar-kronos' className='shadow-sm' fixed='top' expand='lg' variant='light' collapseOnSelect>
      <Container>
        <Navbar.Brand className='d-flex' as={NavLink} to='/' href='/' exact>D.A.V. Kronos</Navbar.Brand>
        <Navbar.Toggle aria-controls='basic-navbar-nav' />
        <Navbar.Collapse id='basic-navbar-nav' className='flex-wrap'>
          <Nav>
            <NavDropdown title={t('association')} id='basic-nav-dropdown'>
              <NavDropdown.Item as={NavLink} to='/commissions' href='/commissions'>{t('committees')}</NavDropdown.Item>
              {getPageLinksForMenu(pages, 'Vereniging')}
              <NavDropdown.Item as={NavLink} to='/kronometers' href='/kronometers'>{t('kronometers')}</NavDropdown.Item>
              <NavDropdown.Item as={NavLink} to='/photoalbums' href='/photoalbums'>{t('photos')}</NavDropdown.Item>
            </NavDropdown>
            <NavDropdown title={t('trainings')} id='basic-nav-dropdown'>
              {getPageLinksForMenu(pages, 'Trainingen')}
            </NavDropdown>
            <NavDropdown title={t('matches')} id='basic-nav-dropdown'>
              <NavDropdown.Item target='_blank' href='http://www.campusloop.nl'>Campusloop</NavDropdown.Item>
              <NavDropdown.Item target='_blank' href='http://jkg.kronos.nl'>Johan Knaap Games</NavDropdown.Item>
              {getPageLinksForMenu(pages, 'Wedstrijden')}
            </NavDropdown>
            <Nav.Link as={NavLink} to='/agendaitems' href='/agendaitems'>{t('agenda')}</Nav.Link>
            <Nav.Link as={NavLink} to='/results' href='/results'>{t('results')}</Nav.Link>
            <Nav.Link as={NavLink} to='/contact' href='/contact'>{t('contact')}</Nav.Link>

          </Nav>
          <Nav>
            {getHighlightPages(pages)}
          </Nav>
          <Nav className='ml-auto'>

            <Can I='read' an='User'>
              <Nav.Link as={NavLink} to='/users'>{t('users')}</Nav.Link>
            </Can>
            <UserMenu />
            <LanguageSwitch />
          </Nav>
        </Navbar.Collapse>
      </Container>
    </Navbar>
  )
}

export default NavBar
