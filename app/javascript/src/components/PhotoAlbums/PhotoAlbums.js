import React from 'react'
import { Button, Col, Row } from 'react-bootstrap'
import PhotoAlbumCover from './PhotoAlbumCover'
import DefaultSpinner from '../Generic/Spinner'
import Paginate from '../Generic/Paginate'
import { useQuery } from 'react-query'
import { getPhotoAlbums } from './queries'
import { Link } from 'react-router-dom'
import { Can } from '../../utils/auth-helper'
import { useTranslation } from 'react-i18next'

function PhotoAlbums (props) {
  const { isLoading, isError, data: photoAlbums, error } = useQuery('photoalbums', getPhotoAlbums)
  const { t } = useTranslation('generic')

  const Item = ({ item }) => <PhotoAlbumCover photoAlbum={item} />

  return (
    <>
      <Row>
        <Col><h1>{t('photoAlbumPage:header')}</h1></Col>
      </Row>

      {isLoading && <DefaultSpinner />}
      {photoAlbums && photoAlbums.length > 0 && <Paginate data={photoAlbums} itemsPerPage={8} colSize={{ sm: 6, md: 3 }} Item={Item} />}

      <Can I='create' a='Photoalbum'>
        <Button as={Link} to='/photoalbums/new'>{t('addModel', { model: t('models:modelNames.photoAlbum') })}</Button>
      </Can>
    </>
  )
}

function sortPhotoAlbums (a, b) {
  return b.created_at - a.created_at
}

export default PhotoAlbums
