import f from 'date-fns/format'
import fD from 'date-fns/formatDistanceToNow';
import nl from 'date-fns/locale/nl'
import en from 'date-fns/locale/en-GB'
const locales = {en, nl}

// by providing a default string of 'PP' or any of its variants for `formatStr`
// it will format dates in whichever way is appropriate to the locale
function format (date, formatStr = 'PP') {
    if (!(date instanceof Date)) {
        date = new Date(date)
    }
    return f(date, formatStr, {
        locale: locales["nl"] // or global.__localeId__
    })
}

function formatDistanceToNow(date) {
    return fD(date, {locale: locales['nl']})
}

export {format, formatDistanceToNow}