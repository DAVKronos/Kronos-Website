import React from 'react'
import { useQuery, useQueryCache } from 'react-query'
import { Table, Button } from 'react-bootstrap'
import { getPages, removePage } from '../Pages/queries'
import { Link } from 'react-router-dom'
import { BsFillXCircleFill, BsFillCheckCircleFill } from 'react-icons/bs'
import { Can } from '../../utils/auth-helper'
import { useTranslation } from 'react-i18next'

const Pages = () => {
  const { isLoading, isError, data: pages, error } = useQuery('pages', getPages)
  const { t } = useTranslation('generic')
  const queryCache = useQueryCache()
  return (
    <>
      <h1>Informatie pagina's</h1>
      <Table striped>
        <thead>
          <tr>
            <th>
              Pagina tag
            </th>
            <th>
              Pagina tag (en)
            </th>
            <th>
              Menu
            </th>
            <th>
              Public
            </th>
            <th>
              Highlight
            </th>
            <th colSpan={3}>
              Acties
            </th>
          </tr>
        </thead>
        <tbody>
          {pages && pages.map(page => {
            const onClickRemove = () => {
              return removePage(page.id).then(() => {
                queryCache.invalidateQueries(['pages'], { exact: true })
              })
            }

            return (
              <tr key={page.id}>
                <td>{page.pagetag}</td>
                <td>{page.pagetag_en}</td>
                <td>{page.menu}</td>
                <td>{page.public ? <BsFillCheckCircleFill /> : <BsFillXCircleFill />}</td>
                <td>{page.highlight ? <BsFillCheckCircleFill /> : <BsFillXCircleFill />}</td>
                <td><Link to={`/pages/${page.id}`}>Bekijk</Link></td>
                <td><Link to={`/pages/${page.id}/edit`}>Bewerk</Link></td>
                <td><Link onClick={onClickRemove} to='/pages'>Verwijder</Link></td>
              </tr>
            )
          })}
        </tbody>
      </Table>
      <Can I='create' a='Page'>
        <Button as={Link} to='/pages/new'>{t('addModel', { model: t('models:modelNames.page', { count: 0 }) })}</Button>
      </Can>
    </>
  )
}

export default Pages
