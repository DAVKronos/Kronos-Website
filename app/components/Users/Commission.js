import React, { Component } from 'react'
import { ListGroup } from 'react-bootstrap'
import { useQuery } from 'react-query'
import { useTranslation } from 'react-i18next'
import { getMemberships } from './queries'

class RegularText extends Component {
  state = {
    text: this.props.text
  }

  render () {
    return this.state.text
  }
}

const MembershipList = ({ user }) => {
  const { t, i18n } = useTranslation('generic')
  const lang = i18n.language
  const { isLoading, isError, data, error } = useQuery(['memberships', user.id], getMemberships)
  const commissions = data
  return (
    <>
      {commissions && commissions.map(commission => {
        return <RegularText key={commission.id} text={commission.name} />
      })}
    </>
  )
}

export { MembershipList }
