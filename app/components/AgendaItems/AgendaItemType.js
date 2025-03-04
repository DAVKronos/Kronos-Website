import { useTranslation } from 'react-i18next'

const AgendaItemTypeName = ({ agendaItemType }) => {
  const { i18n } = useTranslation('generic')
  const name = i18n.language === 'nl' ? agendaItemType && agendaItemType.name : agendaItemType && agendaItemType.name_en
  return name
}

export { AgendaItemTypeName }
