import { format } from 'date-fns'
import { enGB, nl } from 'date-fns/locale'

const locales = {enGB, nl}

// by providing a default string of 'PP' or any of its variants for `formatStr`
// it will format dates in whichever way is appropriate to the locale
export default function (date, formatStr = 'PP') {
    return format(date, formatStr, {
        locale: locales["nl"] // or global.__localeId__
    })
}