const parseParams = (params = '') => {
  const rawParams = params.replace('?', '').split('&')
  const extractedParams = {}
  rawParams.forEach((item) => {
    item = item.split('=')
    extractedParams[item[0]] = item[1]
  })
  return extractedParams
}

export { parseParams }
