import React from 'react'
import { Row, Col } from 'react-bootstrap'
import { Link } from 'react-router-dom'
import { format } from '../../utils/date-format'
import { useTranslation } from 'react-i18next'
import { BsPersonFill } from 'react-icons/bs'

const AgendaItem = ({ item }) => {
  const date = new Date(item.date)
  const { i18n } = useTranslation('homepage')
  const name = i18n.language === 'nl' ? item.name : item.name_en
  if (item.subscriptions.length > 0) {
    return (
      <Row as={Link} to={`/agendaitems/${item.id}`}>
        <Col xs={2}><h5>
          <small>{format(date, 'ccc', i18n.language)}</small> <br />
          {date.getDate()}<br />
          <small>{format(date, 'MMM', i18n.language)}</small>
                    </h5>
        </Col>
        <Col xs={8}><h5>{name}</h5></Col>
        <Col xs={2}><h5><BsPersonFill /><small>{item.subscriptions.length}</small></h5></Col>
      </Row>
    )
  } else {
    return (
      <Row as={Link} to={`/agendaitems/${item.id}`}>
        <Col xs={2}><h5>
          <small>{format(date, 'ccc', i18n.language)}</small> <br />
          {date.getDate()}<br />
          <small>{format(date, 'MMM', i18n.language)}</small>
                    </h5>
        </Col>
        <Col xs={8}><h5>{name}</h5></Col>
      </Row>
    )
  }
}

export default AgendaItem
