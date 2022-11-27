process.env.NODE_ENV = process.env.NODE_ENV || 'development'
const environment = require('./environment')

const Visualizer = require('webpack-visualizer-plugin');
//...
environment.plugins.append('Visualizer', new Visualizer({
  filename: './stats.html'
})),
module.exports = environment.toWebpackConfig()
