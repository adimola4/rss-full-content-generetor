import API_ROOT from './api_root';

const { createProxyMiddleware } = require('http-proxy-middleware');


module.exports = function(app) {
    app.use(
        '/api',
        createProxyMiddleware({
            target:  API_ROOT ,
            changeOrigin: true,
        })
    );
};