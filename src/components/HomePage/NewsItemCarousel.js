import React from 'react'
import { Carousel } from 'react-bootstrap'
import { getAPIHostUrl } from '../../utils/rest-helper'
import { useTranslation } from 'react-i18next'
import MultiLanguageText from '../Generic/MultiLanguageText'

const NewsItemCaroursel = ({ items }) => {
  const { i18n } = useTranslation('homepage')

  return (
    <Carousel pause={false} interval={10000}>
      {items.map(item => {
        return (
          <Carousel.Item key={item.id}>
            <img
              className='d-block w-100'
              src={getAPIHostUrl(item.articlephoto_url_carrousel)}
              alt={item.title_en}
            />
            <Carousel.Caption>
              <h3><MultiLanguageText nl={item.title} en={item.title_en}/></h3>
            </Carousel.Caption>
          </Carousel.Item>
        )
      })}

    </Carousel>
  )
}

export default NewsItemCaroursel
