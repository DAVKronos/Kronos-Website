// Support component names relative to this directory:
const componentRequireContext = require.context('src', true)
const ReactRailsUJS = require('react_ujs')
ReactRailsUJS.useContext(componentRequireContext)
