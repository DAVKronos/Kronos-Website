import { useQuery } from 'react-query'
import { getAgendaitemType } from './queries'
import { useTranslation } from 'react-i18next'

const AgendaItemTypeName = ({ id }) => {
  const { i18n } = useTranslation('generic')
  const { isLoading, isError, data, error } = useQuery(['agendaitemtypes', id], getAgendaitemType)
  const agendaItemType = data || null
  const name = i18n.language === 'nl' ? agendaItemType && agendaItemType.name : agendaItemType && agendaItemType.name_en
  return name
}

export { AgendaItemTypeName }
