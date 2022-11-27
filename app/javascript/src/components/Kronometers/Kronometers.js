import React, { useState } from 'react'
import { Row, Col, Card, Button } from 'react-bootstrap'
import { Link, useHistory } from 'react-router-dom'
import {
  getKronometersByFolder,
  getKronometers,
  getFolders,
  getFolderById,
  removeFolder,
  removeKronometer
} from './queries'
import { useQuery, useQueryCache } from 'react-query'
import { useTranslation } from 'react-i18next'
import DefaultSpinner from '../Generic/Spinner'
import { BsFolder, BsArrowUp } from 'react-icons/bs'
import { Can } from '../../utils/auth-helper'

const EditFolderButtons = ({ folderId }) => {
  if (!folderId) {
    return null
  }
  const [removing, setRemoving] = useState(false)
  const history = useHistory()

  const onClickRemove = () => {
    setRemoving(true)
    removeFolder(folderId).then(() => {
      setRemoving(false)
      history.push('/kronometers')
    })
  }

  return (
    <Col
      style={{ display: 'flex', alignItems: 'flex-end', justifyContent: 'end' }}
    >
      <Can I='update' a='Folder'>
        <Button
          variant='warning'
          disabled={removing}
          size='sm'
          as={Link}
          to={`/folders/${folderId}/edit`}
        >
          Bewerk
        </Button>
      </Can>
      <Can I='delete' a='Folder'>
        <Button
          variant='danger'
          disabled={removing}
          size='sm'
          onClick={onClickRemove}
        >
          {removing ? <DefaultSpinner inline size='sm' /> : 'Verwijder'}
        </Button>
      </Can>
    </Col>
  )
}

const Kronometers = (props) => {
  const queryCache = useQueryCache()
  const folderId =
    props.match &&
    props.match.params &&
    props.match.params.folder_id &&
    parseInt(props.match.params.folder_id)
  let folderName,
    folders,
    isFolderLoading,
    kronometers,
    isKronometerLoading,
    parentId
  let queryParams
  const { t } = useTranslation('kronometerPage')
  if (!folderId) {
    const folderQuery = useQuery('folders', getFolders)
    queryParams = 'kronometers'
    const kronometerQuery = useQuery(queryParams, getKronometers)
    isFolderLoading = folderQuery.isLoading
    folderName = t('mainFolder')
    folders = folderQuery.data
    kronometers = kronometerQuery.data
    isKronometerLoading = kronometerQuery.isLoading
  } else {
    const folderQuery = useQuery(['folders', folderId], getFolderById)
    queryParams = ['folders', folderId, 'kronometers']
    const kronometerQuery = useQuery(queryParams, getKronometersByFolder)
    isFolderLoading = folderQuery.isLoading
    if (folderQuery.data) {
      folderName = folderQuery.data.name
      folders = folderQuery.data.folders
      parentId = folderQuery.data.folder_id
    }

    kronometers = kronometerQuery.data
    isKronometerLoading = kronometerQuery.isLoading
  }

  const onClickRemove = (kronometerId) => {
    removeKronometer(kronometerId).then(() => {
      queryCache.invalidateQueries(queryParams)
    })
  }

  const parentUrl = parentId ? `/kronometers/${parentId}` : '/kronometers'
  const parentButton = folderId && (
    <Button as={Link} to={parentUrl} size='sm'>
      <BsArrowUp />
    </Button>
  )

  return (
    <>
      <Row>
        <Col>
          <h1>{isFolderLoading ? 'Loading...' : folderName}</h1>
        </Col>
        <EditFolderButtons folderId={folderId} />
      </Row>
      <Row>
        <Col>
          <h2>
            {parentButton} {t('subfolders')}
          </h2>
        </Col>
      </Row>
      <Row>
        {isFolderLoading && <DefaultSpinner />}
        {folders &&
          folders.map((folder) => {
            return (
              <Col key={folder.id} md={3} sm={4}>
                <Card>
                  <Card.Body>
                    <Card.Title>
                      <Link to={`/kronometers/${folder.id}`}>
                        <BsFolder /> {folder.name}
                      </Link>
                    </Card.Title>
                  </Card.Body>
                </Card>
              </Col>
            )
          })}
      </Row>
      <Row>
        <Col>
          <h2>{t('documents')}</h2>
        </Col>
      </Row>
      <Row>
        {isKronometerLoading && <DefaultSpinner />}
        {kronometers &&
          kronometers.map((kronometer) => {
            return (
              <Col key={kronometer.id} md={3} sm={4}>
                <Card>
                  <a target='_blank' href={kronometer.url_original} rel='noreferrer'>
                    <Card.Img src={kronometer.url_thumb} />
                  </a>
                  <Card.Body>
                    <Card.Title>{kronometer.name}</Card.Title>
                    <Card.Subtitle className='mb-2 text-muted'>
                      {kronometer.date}
                    </Card.Subtitle>
                    <Can I='update' a='Kronometer'>
                      <Button
                        size='sm'
                        variant='warning'
                        as={Link}
                        to={`/kronometers/${kronometer.id}/edit`}
                      >
                        {t('edit')}
                      </Button>
                    </Can>
                    <Can I='delete' a='Kronometer'>
                      <Button
                        size='sm'
                        variant='danger'
                        onClick={() => onClickRemove(kronometer.id)}
                      >
                        {t('remove')}
                      </Button>
                    </Can>
                  </Card.Body>
                </Card>
              </Col>
            )
          })}
      </Row>
      <Row>
        <Col>
          <Can I='create' a='Folder'>
            <Button as={Link} to='/folders/new'>
              {t('generic:addModel', {
                model: t('models:modelNames.folder', { count: 0 })
              })}
            </Button>
          </Can>
          <Can I='create' a='Kronometer'>
            <Button as={Link} to='/kronometers/new'>
              {t('generic:addModel', {
                model: t('models:modelNames.kronometer', { count: 0 })
              })}
            </Button>
          </Can>
        </Col>
      </Row>
    </>
  )
}

export default Kronometers
