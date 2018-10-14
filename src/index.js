require('./index.html');
const queryString = require('query-string');
const { Elm } = require('./Main.elm');

const urlParams = queryString.parse(location.search);

Elm.Main.init({
  node: document.getElementById('app-root'),
  flags: {
    debug: urlParams.debug === "true"
  }
});