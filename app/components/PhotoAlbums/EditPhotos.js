import React, { useState } from 'react'
import { useQuery, useQueryCache } from 'react-query'
import { addPhotosToAlbums, deletePhoto, getPhotos } from './queries'
import { Button, Card, Col, Form, ProgressBar, Row } from 'react-bootstrap'
import { getAPIHostUrl } from '../../utils/rest-helper'
import DefaultSpinner from '../Generic/Spinner'
import { useTranslation } from 'react-i18next'

const EditPhotos = ({ photoAlbumId }) => {
  const { t } = useTranslation('photoAlbumPage')
  const queryCache = useQueryCache()
  const { isLoading, isError, data: photos, error } = useQuery(['photos', photoAlbumId], getPhotos)
  const [files, setFiles] = useState(null)
  const [progress, setProgress] = useState(0)
  const [uploading, setUploading] = useState(false)

  const handleFileUpload = (e) => {
    setProgress(0)
    setFiles(e.target.files)
  }

  const onClickUpload = () => {
    setUploading(true)
    addPhotosToAlbums(photoAlbumId, files, onUploadProgress).then(() => {
      setUploading(false)
      return queryCache.invalidateQueries(['photos', photoAlbumId])
    })
  }

  const onUploadProgress = (e) => {
    setProgress(e.loaded * 100 / e.total)
  }

  const onClickRemove = (id) => {
    deletePhoto(photoAlbumId, id).then(() => {
      return queryCache.invalidateQueries(['photos', photoAlbumId])
    })
  }

  return (
    <div>
      <h2>{t('editPhotos')}</h2>
      <div>
        <h3>{t('generic:add')}</h3>
        <Form.File onChange={handleFileUpload} multiple />
        <ProgressBar style={{ maxWidth: 400 }} now={progress} variant={progress === 100 && 'success'} animated />
        <Button onClick={onClickUpload}>
          {uploading && <DefaultSpinner inline size='sm' />} {t('upload')}
        </Button>

      </div>
      <Row className='row-margin'>
        {photos && photos.map(photo => {
          return (
            <Col key={photo.id} md={2} sm={2} style={{ marginBottom: 5 }}>
              <Card>
                <Card.Img src={getAPIHostUrl(photo.photo_url_thumb)} />
                <Card.Body style={{ padding: '0.2rem' }}>
                  <Button size='sm' variant='danger' onClick={() => onClickRemove(photo.id)}>{t('generic:remove')}</Button>
                </Card.Body>
              </Card>
            </Col>
          )
        })}
      </Row>
    </div>
  )
}

export default EditPhotos
