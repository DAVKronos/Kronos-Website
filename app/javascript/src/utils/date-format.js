import f from 'date-fns/format'
import fD from 'date-fns/formatDistanceToNow'
import nl from 'date-fns/locale/nl'
import en from 'date-fns/locale/en-GB'
const locales = { en, nl }

function langFromLocale(locale) {
  if (locale.length > 2 && locale.split('-').length > 1) {
    return locale.split('-')[0]
  }
  return locale
}


// by providing a default string of 'PP' or any of its variants for `formatStr`
// it will format dates in whichever way is appropriate to the locale
function format (date, formatStr = 'PP', currentLocale = 'nl') {
  const locale = langFromLocale(currentLocale)
  
  if (!(date instanceof Date)) {
    date = new Date(date)
  }
  return f(date, formatStr, {
    locale: locales[locale] // or global.__localeId__
  })
}

function formatDistanceToNow (date, currentLocale = 'nl', addSuffix = false) {
  return fD(date, { locale: locales[currentLocale], addSuffix })
}

export { format, formatDistanceToNow, langFromLocale }
