import React from 'react'
import { Link } from 'react-router-dom'
import { Row, Col, Card } from 'react-bootstrap'
import { getAPIHostUrl } from '../../utils/rest-helper'
import { format } from '../../utils/date-format'
import { useQuery } from 'react-query'
import { getPhotoAlbum, getPhotos } from './queries'
import { useTranslation } from 'react-i18next'
import DefaultSpinner from '../Generic/Spinner'
import Paginate from '../Generic/Paginate'

const PhotoItem = ({ item: photo }) => {
  return (
    <Link to={`/photoalbums/${photo.photoalbum_id}/${photo.id}`}>
      <Card>
        <Card.Img src={getAPIHostUrl(photo.photo_url_thumb)} />
      </Card>
    </Link>
  )
}

const PhotoAlbum = (props) => {
  const id = parseInt(props.match.params.id)

  const { t, i18n } = useTranslation(['photoalbum', 'models'])

  const { isLoading: albumLoading, isError, data: photoAlbum, error } = useQuery(['photoalbums', id], getPhotoAlbum)
  const { isLoading: photosLoading, data: photos } = useQuery(['photos', id], getPhotos)

  if (albumLoading || photosLoading) {
    return <DefaultSpinner />
  }

  if (!photoAlbum) {
    return null
  }
  if (!photos || photos.length === 0) {
    return <h3>{t('no_photos')}</h3>
  }

  return (
    <>
      <Row>
        <Col>
          <h1>{photoAlbum.name}</h1>
          <p>{t('models:generic.created_at')}: {format(photoAlbum.created_at, 'PPP p', i18n.language)}</p>
        </Col>
      </Row>
      <Paginate data={photos} colSize={{ sm: 6, md: 3 }} Item={PhotoItem} itemsPerPage={12} />
    </>
  )
}

export default PhotoAlbum
