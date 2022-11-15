import { useQuery } from 'react-query'
import { getUserType } from './queries'
import { useTranslation } from 'react-i18next'

const UserTypeName = ({ id }) => {
  const { i18n } = useTranslation('generic')
  const { isLoading, isError, data, error } = useQuery(['user_types', id], getUserType)
  const userType = data || null
  const name = i18n.language === 'nl' ? userType && userType.name : userType && userType.name_en
  return name
}

export { UserTypeName }
