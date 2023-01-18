import React, { useState } from 'react'
import { Link } from 'react-router-dom'
import { Nav, Col, Row, Image, FormControl, Button } from 'react-bootstrap'
import { getAPIHostUrl } from '../../utils/rest-helper'
import { format } from '../../utils/date-format'
import { useQuery } from 'react-query'
import { getUsers, getUserTypes } from './queries'
import { useTranslation } from 'react-i18next'
import DefaultSpinner from '../Generic/Spinner'
import { Can } from '../../utils/auth-helper'

function UserTypesFilter ({ filter, onChangeFilter }) {
  const { t, i18n } = useTranslation('generic')
  const { isLoading, isError, data, error } = useQuery('usertypes', getUserTypes)
  const lang = i18n.language
  return (
    <Nav variant='pills'>
      <Nav.Item key='all'>
        <Nav.Link active={filter == null} onClick={() => onChangeFilter(null)}>
          {t('allItems')}
        </Nav.Link>
      </Nav.Item>
      {data && data.map(userType => {
        return (
          <Nav.Item key={userType.id}>
            <Nav.Link
              active={filter === userType.id}
              onClick={() => onChangeFilter(userType.id)}
            >
              {i18n.language === 'nl' ? userType && userType.name : userType && userType.name_en}
            </Nav.Link>
          </Nav.Item>
        )
      })}
    </Nav>
  )
}

function LetterFilter ({ filter, onChangeFilter, alpha_params }) {
  return (
    <Nav variant='tabs'>
      {alpha_params && alpha_params.map(letter => {
        console.log(letter)
        return (
          <Nav.Item key={alpha_params.indexOf(letter)}>
            <Nav.Link
              active={filter === letter}
              onClick={() => onChangeFilter(letter)}
            >
              {letter}
            </Nav.Link>
          </Nav.Item>
        )
      })}
    </Nav>
  )
}

const Users = () => {
  const { t, i18n } = useTranslation('userpage')
  const lang = i18n.language
  const [filter, setFilter] = useState(null)
  const [lfilter, setlFilter] = useState(null)
  const [nameFilter, setNameFilter] = useState('')

  let { isLoading, isError, data: users } = useQuery('users', getUsers)
  if (isLoading) {
    return <DefaultSpinner />
  }

  const names = users.map(item => item.name)
  let alpha_params = names.map(name => name.charAt(0).normalize('NFD').replace(/([\u0300-\u036f]|[^0-9a-zA-Z])/g, '').toUpperCase())
  console.log(alpha_params)
  alpha_params = [...new Set(alpha_params)].sort()

  const onChangeFilter = (newFilter) => {
    if (filter !== newFilter) {
      setFilter(newFilter)
    }
  }
  const onChangeLfilter = (newFilter) => {
    if (lfilter !== newFilter) {
      setlFilter(newFilter)
    } else {
      setlFilter(null)
    }
  }

  if (users && filter) {
    users = users.filter(user => user.user_type_id === filter)
  }
  if (users && lfilter) {
    users = users.filter((user) => user.name.startsWith(lfilter))
  }
  if (users && nameFilter) {
    users = users.filter(user => user.name.toLowerCase().indexOf(nameFilter.toLowerCase()) >= 0)
  }

  return (
    <>
      <h1>{t('kronauts')}</h1>
      <Row className='row-margin'>
        <Col md={12}>
          <UserTypesFilter filter={filter} onChangeFilter={onChangeFilter} />
        </Col>
      </Row>
      <Row className='row-margin'>
        <Col md={9}>
          <LetterFilter filter={lfilter} onChangeFilter={onChangeLfilter} alpha_params={alpha_params} />
        </Col>
        <Col md={3}>
          <FormControl className='mr-sm-1' type='text' placeholder='Name' value={nameFilter} onChange={(event) => setNameFilter(event.target.value)} />

        </Col>
      </Row>
      <Row className='row-margin'>
        <Col md={12}>
          <Row>
            {isLoading && <DefaultSpinner />}
            {users && users.map(user => {
              return (
                <Col key={user.id} sm={6} md={3}>
                  <Link to={`/users/${user.id}`} className='user'>
                    <div className='thumbnail'>
                      <figure>
                        <Image src={user.avatar_url_pass} />
                        <figcaption>{user.name}</figcaption>
                      </figure>
                    </div>
                  </Link>
                </Col>
              )
            })}
          </Row>
        </Col>
        <Col>
          <Can I='create' a='User'>
            <Button as={Link} to='/users/new'>
              {t('generic:addModel', {
                model: t('models:modelNames.user', { count: 0 })
              })}
            </Button>
          </Can>
        </Col>
      </Row>
    </>
  )
}

export default Users
