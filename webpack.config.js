

module.exports = {
  devtool: 'source-map',

  module: {
    rules: [{
        test: /\.html$/,
        exclude: /node_modules/,
        loader: 'file-loader?name=[name].[ext]'
      },
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader: "elm-webpack-loader",
        options: {
          debug: true
        }
      }
    ]
  },

  devServer: {
    inline: true,
    stats: 'errors-only'
  }
};