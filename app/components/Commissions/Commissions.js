import React, { useState } from 'react'
import { Table, Button } from 'react-bootstrap'
import { Link } from 'react-router-dom'
import { useQuery, useQueryCache } from 'react-query'
import { useTranslation } from 'react-i18next'
import { getCommissions, removeCommision } from './queries'
import MultiLanguageText from '../Generic/MultiLanguageText'
import { Can } from '../../utils/auth-helper'
import DefaultSpinner from '../Generic/Spinner'

const CommissionRow = ({ commission, removeFunction }) => {
  const [removing, setRemoving] = useState(false)

  const onClickRemove = () => {
    setRemoving(true)
    removeFunction(commission.id).then(() => {
      setRemoving(false)
    })
  }
  return (
    <tr key={commission.id}>
      <td>
        <Link to={`/commissions/${commission.id}`}>
          <MultiLanguageText nl={commission.name} en={commission.name_en} />
        </Link>
      </td>
      <Can I='update' a='Commission'>
        <td>
          <Button
            variant='warning'
            disabled={removing}
            size='sm'
            as={Link}
            to={`commissions/${commission.id}/edit`}
          >
            Bewerk
          </Button>
        </td>
      </Can>
      <Can I='delete' a='Commission'>
        <td>
          <Button
            variant='danger'
            disabled={removing}
            size='sm'
            onClick={onClickRemove}
          >
            {removing ? <DefaultSpinner inline size='sm' /> : 'Verwijder'}
          </Button>
        </td>
      </Can>
    </tr>
  )
}

function Commissions (props) {
  const { isLoading, isError, data, error } = useQuery(
    'commissions',
    getCommissions
  )

  const commissions = data
  const { t } = useTranslation('committeePage')
  const queryCache = useQueryCache()
  const removeFunction = (id) => {
    return removeCommision(id).then(() => {
      queryCache.invalidateQueries(['commissions'], { exact: true })
    })
  }

  return (
    <>
      <h1>{t('headerText')}</h1>
      <p className='lead'>{t('pageDescription')}</p>
      <Table striped>
        <thead>
          <tr>
            <th>{t('name')}</th>
            <Can I='update' a='Commission'>
              <th />
            </Can>
            <Can I='delete' a='Commission'>
              <th />
            </Can>
          </tr>
        </thead>
        <tbody>
          {commissions &&
            commissions.map((commission) => {
              return (
                <CommissionRow
                  key={commission.id}
                  commission={commission}
                  removeFunction={removeFunction}
                />
              )
            })}
        </tbody>
      </Table>
      {isLoading && <DefaultSpinner />}
      <Can I='create' a='Commission'>
        <Button as={Link} to='/commissions/new'>
          {t('generic:addModel', {
            model: t('models:modelNames.commission', { count: 0 })
          })}
        </Button>
      </Can>
    </>
  )
}

export default Commissions
