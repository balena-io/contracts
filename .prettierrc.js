const fs = require('fs');

module.exports = JSON.parse(
  fs.readFileSync(
    __dirname + '/node_modules/@balena/lint/config/.prettierrc',
    'utf8',
  ),
);
