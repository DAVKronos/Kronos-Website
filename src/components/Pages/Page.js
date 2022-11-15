import React from 'react'
import ReactMarkdown from 'react-markdown'
import { Button } from 'react-bootstrap'
import Spinner from '../Generic/Spinner'
import { useQuery } from 'react-query'
import { getPage, getPageByPageTag, removePage } from './queries'
import MultiLanguageText from '../Generic/MultiLanguageText'
import { Link, useHistory } from 'react-router-dom'
import { Can } from '../../utils/auth-helper'
import { subject } from '@casl/ability'
import { useTranslation } from 'react-i18next'

const PageComponent = ({ page, isLoading }) => {
  const { t, i18n } = useTranslation('generic')
  const lang = i18n.language
  const history = useHistory()

  if (isLoading) {
    return <Spinner />
  }

  if (!page) {
    return <h1>Page not found</h1>
  }

  const renderMarkdown = (text) => {
    text = text.replace('kronos.nl/', 'kronos.nl/app/')
    return <ReactMarkdown source={text} escapeHtml={false} />
  }

  const onClickRemove = () => {
    return removePage(page.id).then(() => {
	  history.push('/admin/pages')
    })
  }

  return (
    <div>
      <Can I='update' this={subject('Page', page)}>
        <Button
          variant='warning' className='align-self-center' as={Link}
          to={`/pages/${page.id}/edit`}
        >{t('edit')}
        </Button>
      </Can>
      <Can I='delete' this={subject('Page', page)}>
        <Button variant='danger' className='align-self-center' onClick={onClickRemove}>
          {t('remove')}
        </Button>
      </Can>

      <h1><MultiLanguageText nl={page.pagetag} en={page.pagetag_en} /></h1>
      <MultiLanguageText nl={page.information} en={page.information_en} renderFunction={renderMarkdown} />
    </div>
  )
}

const Page = (props) => {
  const { id } = props.match.params
  const { isLoading, isError, data, error } = useQuery(['pages', id], getPage)

  return <PageComponent page={data} isLoading={isLoading} />
}

const PageWithTag = (props) => {
  const { pagetag } = props.match.params
  const { isLoading, isError, data, error } = useQuery(['pages', pagetag], getPageByPageTag)

  return <PageComponent page={data} isLoading={isLoading} />
}

export { Page, PageWithTag }
