// Support component names relative to this directory:
var componentRequireContext = require.context("src", true);
var ReactRailsUJS = require("react_ujs");
import '../src/App.scss';
const images = require.context('src/images', true)
ReactRailsUJS.useContext(componentRequireContext);
