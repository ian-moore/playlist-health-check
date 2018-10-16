require('./index.html');
const queryString = require('query-string');
const { Elm } = require('./Main.elm');

const urlParams = queryString.parse(location.search);

window.addEventListener('DOMContentLoaded', () => {
  Elm.Main.init({
    flags: {
      debug: urlParams.debug === "true"
    }
  });
});