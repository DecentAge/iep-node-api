'use strict';

const express = require('express');
const swaggerUi = require('swagger-ui-express');
const yaml = require('js-yaml');
const fs = require('fs');
const path = require('path');

const serverPort = process.env.PORT || 9005;
const publicPath = process.env.PUBLIC_PATH || '';
const specFile = path.join(__dirname, 'api', 'node.json');
// The spec is JSON-with-YAML-multi-line-strings; js-yaml handles both forms.
const swaggerDoc = yaml.load(fs.readFileSync(specFile, 'utf8'));

const app = express();

app.get(`${publicPath}/node.json`, (_req, res) => res.json(swaggerDoc));

app.use(
  `${publicPath}/docs`,
  swaggerUi.serve,
  swaggerUi.setup(swaggerDoc, {
    explorer: false,
    swaggerOptions: { supportedSubmitMethods: [] },
  })
);

app.listen(serverPort, () => {
  console.log(`Server listening on port ${serverPort} (http://localhost:${serverPort})`);
  console.log(`Swagger UI: http://localhost:${serverPort}${publicPath}/docs`);
});
