import React, { useState } from 'react'
import { useHistory, NavLink } from 'react-router-dom'
import { Button, Form, FormControl, Nav } from 'react-bootstrap'
import { format } from '../../utils/date-format'
import { useTranslation } from 'react-i18next'

const MonthSwitcher = ({ date }) => {
  const history = useHistory()
  const { t, i18n } = useTranslation('generic')
  const lang = i18n.language
  const [searchMonth, setSearchMonth] = useState('')
  const [searchYear, setSearchYear] = useState('')
  const month = date.getMonth()
  const year = date.getFullYear()

  const getRecords = () => {
    const pathname = history.location.pathname
    if (!pathname.endsWith('records')) {
      history.push({
        pathname: pathname.concat('/records'),
        search: '?loc=out&sex=male'
      })
    }
  }
  const changeDate = (date) => {
    const newYear = date.getFullYear()
    const newMonth = date.getMonth() + 1
    const pathname = history.location.pathname
    history.push({
      pathname: pathname.endsWith('records') ? pathname.substring(0, pathname.length - 8) : pathname,
      search: `?year=${newYear}&month=${newMonth}`
    })
  }

  const onClickSearch = (event) => {
    event.preventDefault()
    if (searchYear && searchMonth) {
      changeDate(new Date(searchYear, searchMonth - 1))
      setSearchMonth('')
      setSearchYear('')
    }
  }
  const prev = new Date(year, month - 1)
  const now = new Date(year, month)
  const next = new Date(year, month + 1)
  return (
    <Nav variant='tabs'>
      <Nav.Item>
        <Nav.Link
          onClick={() => changeDate(prev)}
        >{format(prev, 'MMM yyyy', lang)}
        </Nav.Link>
      </Nav.Item>
      <Nav.Item>
        <Nav.Link active={!history.location.pathname.endsWith('records')} onClick={() => changeDate(now)}>{format(date, 'MMM yyyy', lang)}</Nav.Link>
      </Nav.Item>
      <Nav.Item>
        <Nav.Link
          onClick={() => changeDate(next)}
        >{format(next, 'MMM yyyy', lang)}
        </Nav.Link>
      </Nav.Item>
      <Nav.Item>
        <Nav.Link active={history.location.pathname.endsWith('records')} onClick={() => getRecords()}>Clubrecords</Nav.Link>
      </Nav.Item>
      <Nav.Item>
        <Form inline onSubmit={onClickSearch}>
          <FormControl className='monthswitcher-month mr-sm-1' type='text' placeholder='MM' value={searchMonth} onChange={(event) => setSearchMonth(event.target.value)} />
          <FormControl className='monthswitcher-year mr-sm-1' type='text' placeholder='YYYY' value={searchYear} onChange={(event) => setSearchYear(event.target.value)} />
          <Button variant='outline-success' type='submit'>{t('search')}</Button>
        </Form>
      </Nav.Item>
    </Nav>
  )
}

export default MonthSwitcher
