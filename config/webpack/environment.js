const { environment } = require('@rails/webpacker')
const webpack = require('webpack')
const supportedLocales = ['en-UK', 'nl']
environment.plugins.prepend(
      'DateFnsContextReplacement',
    new webpack.ContextReplacementPlugin(
        /date\-fns[\/\\]/,
        new RegExp(`[/\\\\\](${supportedLocales.join('|')})[/\\\\\]index\.js$`)
    )
)

environment.splitChunks()

module.exports = environment