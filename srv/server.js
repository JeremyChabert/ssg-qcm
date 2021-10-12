const cds = require('@sap/cds');
const proxy = require('@sap/cds-odata-v2-adapter-proxy');

if (process.env.NODE_ENV !== 'production') {
  const cds_swagger = require('cds-swagger-ui-express');
  cds.on(
    'bootstrap',
    (app) => app.use(proxy()),
    (app) => app.use(cds_swagger())
  );
}

module.exports = cds.server;
 