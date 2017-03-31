const { resolve } = require('path');
const webpack = require('webpack');

module.exports = {
  entry: [
    'react-hot-loader/patch',
    // activate HMR for React

    'webpack-dev-server/client?http://localhost:8080',
    // bundle the client for webpack-dev-server
    // and connect to the provided endpoint

    'webpack/hot/only-dev-server',
    // bundle the client for hot reloading
    // only- means to only hot reload for successful updates

    './index.js'
    // the entry point of our app
  ],
  output: {
    filename: 'bundle.js',
    // the output bundle

    path: resolve(__dirname, 'docs'), // changed 'dist' to 'www'

    publicPath: '/'
    // necessary for HMR to know where to load the hot update chunks
  },

  context: resolve(__dirname, 'src'),

  devtool: 'inline-source-map',
  // devtool: "source-map"

  devServer: {
    hot: true,
    // enable HMR on the server

    contentBase: resolve(__dirname, 'docs'), // changed 'dist' to 'www'
    // match the output path

    publicPath: '/'
    // match the output `publicPath`
  },

  module: {
    rules: [
      {
        test: /\.js$/,
        use: [ 'babel-loader'],
        exclude: /node_modules/
      },
      {
        test: /\.css$/,
        use: [ 'style-loader', 'css-loader'],
      },
      // {
      //   test: /\.(png|woff|woff2|eot|ttf|svg|jpg)$/,
      //   loader: 'url-loader?limit=10000000'
      // },

      // the below webpack config was sourced from this,
      // https://github.com/coryhouse/react-slingshot/issues/128
      // in order to load favicon.
      // {
      //     test: /\.jpe?g$|\.ico$|\.gif$|\.png$|\.svg$|\.woff$|\.ttf$|\.wav$|\.mp3$/,
      //     loader: 'file-loader?name=[name].[ext]'  // <-- retain original file name
      // },
      // {
      //   test: /\.(ttf|woff|jpeg|jpg|png|gif|svg)$/,
      //   use: [{
      //     loader: "file-loader",
      //       options: {
      //         // outputPath: path.join("assets", "/docs"),
      //         // outputPath: path.join("assets", "/"),
      //         // outputPath: resolve(__dirname, 'docs'),
      //         outputPath: path.resolve(__dirname, 'docs/assets'),
      //         // publicPath: "/",
      //         // publicPath: "assets/",
      //         publicPath: "/assets/",
      //         name: '[name]--[hash:base64:5].[ext]'
      //       }
      //   }]
      // }
      // {
      //   test: /\.(jpe?g|png|gif|svg)$/i,
      //   loader: "file-loader?name=/docs/images/[name].[ext]"
      // }
    ],
  },

  plugins: [
    new webpack.HotModuleReplacementPlugin(),
    // enable HMR globally

    new webpack.NamedModulesPlugin(),
    // prints more readable module names in the browser console on HMR updates

    new webpack.ProvidePlugin({
      $: 'jquery',
      jQuery: 'jquery'
    }),
  ],
};
