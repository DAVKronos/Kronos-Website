import React from 'react'
import { useQuery, useQueryCache } from 'react-query'
import DefaultSpinner from '../Generic/Spinner'
import { useHistory } from 'react-router-dom'
import EditObjectComponent from '../Generic/EditObjectComponent'
import { getNewsItem, updateNewsItem } from './queries'
import NewsItemForm from './NewsItemForm'

const EditNewsItemWithData = (props) => {
  const id = parseInt(props.match.params.id)
  const { isLoading, isError, data, error } = useQuery(['newsitems', id], getNewsItem)
  if (isLoading) {
    return <DefaultSpinner />
  }
  return data && <EditNewsItem newsItem={data} />
}

const EditNewsItem = ({ newsItem }) => {
  const queryCache = useQueryCache()
  const history = useHistory()
  const { id, title, title_en, news, news_en } = newsItem
  const editableFields = { title, title_en, news, news_en }
  const onSuccess = (savedNewsItem) => {
    queryCache.setQueryData(['newsitems', savedNewsItem.id], savedNewsItem)
    history.push(`/newsitems/${savedNewsItem.id}`)
  }

  return (
    <EditObjectComponent
      id={id}
      existingObject={editableFields}
      objectName='newsItem'
      updateFunction={updateNewsItem}
      onSuccess={onSuccess}
      FormComponent={NewsItemForm}
    />
  )
}

export default EditNewsItemWithData
