import React from 'react'
import { Row, Col } from 'react-bootstrap'
import { Link } from 'react-router-dom'
import { format } from '../../utils/date-format'
import { useTranslation } from 'react-i18next'
import { BsPersonFill } from 'react-icons/bs'
import MultiLanguageText from '../Generic/MultiLanguageText'

const AgendaItem = ({ item }) => {
  const date = new Date(item.date)
  const { i18n } = useTranslation('homepage')
  return (
    <Row as={Link} to={`/agendaitems/${item.id}`}>
      <Col xs={2}><h5>
        <small>{format(date, 'ccc', i18n.language)}</small> <br />
        {date.getDate()}<br />
        <small>{format(date, 'MMM', i18n.language)}</small>
                  </h5>
      </Col>
      <Col xs={8}><h5><MultiLanguageText nl={item.name} en={item.name_en} /></h5></Col>
      { item.subscriptions.length ? <Col xs={2}><h5><BsPersonFill /><small>{item.subscriptions.length}</small></h5></Col> : null }
    </Row>
  )
  
}

export default AgendaItem
