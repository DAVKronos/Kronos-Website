import React, { useState } from 'react'
import { Table, Button } from 'react-bootstrap'
import { useTranslation } from 'react-i18next'
import DefaultSpinner from '../Generic/Spinner'
import { Link } from 'react-router-dom'

const ListObjectsComponent = ({
  columns = [],
  objects,
  removeFunction,
  modelName,
  baseUrl
}) => {
  const [removing, setRemoving] = useState(null)
  const { t } = useTranslation('generic')
  return (
    <Table striped>
      <thead>
        <tr>
          {columns.map((column) => {
            return <th key={column}>{t(`models:${modelName}.${column}`)}</th>
          })}
          <th colSpan={2}>Acties</th>
        </tr>
      </thead>
      <tbody>
        {objects &&
          objects.map((object) => {
            const onClickRemove = () => {
              setRemoving(object.id)
              removeFunction(object.id).then(() => {
                setRemoving(null)
              })
            }
            const removingThis = removing == object.id

            return (
              <tr key={object.id}>
                {columns.map((column) => {
                  return <td key={`${object.id}/${column}`}>{object[column]}</td>
                })}
                <td>
                  <Button
                    variant='warning'
                    disabled={removingThis}
                    size='sm'
                    as={Link}
                    to={`${baseUrl}/${object.id}/edit`}
                  >
                    Bewerk
                  </Button>
                </td>
                <td>
                  <Button
                    variant='danger'
                    disabled={removingThis}
                    size='sm'
                    onClick={onClickRemove}
                  >
                    {removingThis
                      ? (
                        <DefaultSpinner inline size='sm' />
                        )
                      : (
                          'Verwijder'
                        )}
                  </Button>
                </td>
              </tr>
            )
          })}
      </tbody>
    </Table>
  )
}

export default ListObjectsComponent
