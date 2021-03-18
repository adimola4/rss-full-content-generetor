const { createProxyMiddleware } = require('http-proxy-middleware');

module.exports = function(app) {
    app.use(
        '/api',
        createProxyMiddleware({
            target:   process.env.NODE_ENV === 'development' ? 'http://localhost:3000/' : 'https://rss-full-content-generetor.herokuapp.com/' ,
            changeOrigin: true,
        })
    );
};