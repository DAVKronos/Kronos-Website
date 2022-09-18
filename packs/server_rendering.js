// By default, this pack is loaded for server-side rendering.
// It must expose react_ujs as `ReactRailsUJS` and prepare a require context.
var componentRequireContext = require.context("src", true);
var ReactRailsUJS = require("react_ujs");
import '../src/App';
import '../src/App.scss';
const images = require.context('src/images', true)
ReactRailsUJS.useContext(componentRequireContext);
