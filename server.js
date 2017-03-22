var express = require("express");
var webpackDevMiddleware = require("webpack-dev-middleware");
var webpack = require("webpack");
var webpackConfig = require("./webpack.config");

var app = express();
var compiler = webpack(webpackConfig);

app.use(express.static(__dirname + '/dist'));

app.use(webpackDevMiddleware(compiler, {
  hot: true,
  filename: 'bundle.js',
  publicPath: "/", // Same as `output.publicPath` in most cases.
  stats: {
    colors: true,
  }
}));

app.listen(3000, function () {
  console.log("Listening on port 3000!");
});
