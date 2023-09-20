import React, { useState } from 'react'
import Spinner from '../Generic/Spinner'
import { useQuery } from 'react-query'
import { getCurrentAnnouncement } from './queries'
import { Jumbotron, Button, Row, Col, Image} from 'react-bootstrap'
import { Link } from 'react-router-dom'
import { getLocalSettings, setLocalSettings } from '../../utils/local-settings'
import { useTranslation } from 'react-i18next'

function hideAnnouncement (id) {
  const hiddenAnnouncements = getLocalSettings('hiddenAnnouncements') || []

  hiddenAnnouncements.push(id)
  setLocalSettings('hiddenAnnouncements', hiddenAnnouncements)
}

const Announcement = ({ announcement, isLoading }) => {
  const [hidden, setHidden] = useState(false)
  const { t } = useTranslation('homepage')
  if (hidden) {
    return null
  }

  if (isLoading) {
    return <Spinner />
  }

  const onClick = () => {
    hideAnnouncement(announcement.id)
    setHidden(true)
  }

  return (
    <Jumbotron>
      <Row>
        <Col lg={6}>
          <h1>{announcement.title}</h1>
          <p>{announcement.message}</p>
          <Button variant="outline-danger" to={announcement.url} as={Link}>{t('Read more')}</Button>
        </Col>
        <Col lg={6}>
          <Image src={announcement.background_url}/>
        </Col>
      </Row>
    </Jumbotron>
  )
}

const AnnouncementWithData = () => {
  const { isLoading, isError, data, error } = useQuery(['announcements', 'current'], getCurrentAnnouncement)

  const announcements = data
  if (!announcements || announcements.length == 0) {
    return null
  }

  return <Announcement announcement={announcements[0]} isLoading={isLoading} />
}

export default AnnouncementWithData
