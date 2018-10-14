console.log('hello world!');

require('./index.html');
const { Elm } = require('./Main.elm');
console.log(Elm);

Elm.Main.init(document.getElementById('app-root'));