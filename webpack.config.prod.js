const { resolve } = require('path');
const webpack = require('webpack');

module.exports = {
  entry: [

    './index.js'
    // the entry point of our app
  ],
  output: {
    filename: 'bundle.js',
    // the output bundle

    path: resolve(__dirname, 'docs'),

    publicPath: '/'

  },

  context: resolve(__dirname, 'src'),

  devServer: {

    contentBase: resolve(__dirname, 'docs'),
    // match the output path

    publicPath: '/'
    // match the output `publicPath`
  },

  module: {
    rules: [
      {
        test: /\.js$/,
        use: [
          'babel-loader',
        ],
        exclude: /node_modules/
      },
      {
        test: /\.css$/,
        use: [ 'style-loader','css-loader', 'postcss-loader'],
      },
      {
        test: /\.(png|jpg|svg)$/,
        use: {
          loader: 'url-loader',
        },
      },
    ],
  },

  plugins: [
    new webpack.ProvidePlugin({
      $: 'jquery',
      jQuery: 'jquery'
    }),
  ],
};
