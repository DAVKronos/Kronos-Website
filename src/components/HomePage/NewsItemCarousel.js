import React from 'react'
import { Carousel } from 'react-bootstrap'
import { getAPIHostUrl } from '../../utils/rest-helper'
import { useTranslation } from 'react-i18next'

const NewsItemCaroursel = ({ items }) => {
  const { i18n } = useTranslation('homepage')

  return (
    <Carousel pause={false} interval={10000}>
      {items.map(item => {
        const title = i18n.language === 'nl' ? item.title : item.title_en
        return (
          <Carousel.Item key={item.id}>
            <img
              className='d-block w-100'
              src={getAPIHostUrl(item.articlephoto_url_carrousel)}
              alt={title}
            />
            <Carousel.Caption>
              <h3>{title}</h3>
            </Carousel.Caption>
          </Carousel.Item>
        )
      })}

    </Carousel>
  )
}

export default NewsItemCaroursel
