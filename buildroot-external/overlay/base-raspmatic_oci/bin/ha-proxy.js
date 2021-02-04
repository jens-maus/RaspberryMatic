#!/usr/bin/env node
//
// Node.js based HTTP proxy to rewrite the Location: and non-relative
// urls used in the HomeMatic WebUI of HTTP requests coming from
// Home-Assistent UI so that the Ingress-based HA UI is able to embed
// the WebUI.
//
// Copyright (c) 2021 Jens Maus <mail@jens-maus.de>
//
// Apache 2.0 License applies
//

const express = require('express');
const { createProxyMiddleware } = require('http-proxy-middleware');
const ipaddr = require('ipaddr.js');

const apiProxy = createProxyMiddleware('/', {
  target: 'http://127.0.0.1:80',
  changeOrigin: true, // for vhosted sites,
  //logLevel: 'debug',
  selfHandleResponse: true,
  onProxyRes (proxyRes, req, res) {
    //console.log(proxyRes.statusCode);
    //console.log("response-headers:");
    //console.log(proxyRes.headers);
    //console.log("request-headers:");
    //console.log(req.headers);

    // modify Location: response header
    if(typeof(proxyRes.headers.location) !== 'undefined') {
      var redirect = proxyRes.headers.location;
      redirect = req.headers['x-ingress-path'] + redirect;
      proxyRes.headers.location = redirect;
    }

    const bodyChunks = [];
    proxyRes.on('data', (chunk) => {
      bodyChunks.push(chunk);
    });
    proxyRes.on('end', () => {
      let body = Buffer.concat(bodyChunks);

      // forwarding source status
      res.status(proxyRes.statusCode);

      // forwarding source headers
      Object.keys(proxyRes.headers).forEach((key) => {
           res.append(key, proxyRes.headers[key]);
      });

      // modifying textual response bodies
      if (proxyRes.headers['content-type'] &&
          (
           proxyRes.headers['content-type'].includes('text/') ||
           proxyRes.headers['content-type'].includes('application/javascript') ||
           proxyRes.headers['content-type'].includes('application/json')
          )
         ) {

          // if this a textual response body we make sure to prepend the ingress path
          body = body.toString('latin1');
          body = body.replace(/(?<=["'= \\])\/(api|webui|ise|pda|config|pages|jpages|esp|upnp|tools|addons)(\\?\/)/g,
                              req.headers['x-ingress-path']+'/$1$2');
          body = body.replace(/(?<=["'])(\/index\.htm)/g,
                              req.headers['x-ingress-path']+'$1');

        if(proxyRes.headers['transfer-encoding'] == 'chunked') {
          res.end(new Buffer.from(body));
        } else {
          res.send(new Buffer.from(body));
          res.end();
        }
      } else {
        res.end(body);
      }
    });
  },
});

const app = express();
app.use((req, res, next) => {
  //Get whitelisted range
  let whitelisted_range = ipaddr.parseCIDR(process.env.HM_HAPROXY_SRC);
  //Get source IP
  let source_ip = ipaddr.parse(req.ip.split(':').pop());
  //Check if source IP in whitelisted range
  if(source_ip.match(whitelisted_range)) {
    // allowed, forward to next middleware (proxy)
    next();
  } else {
    // abort request with "403 Forbidden"
    res.status(403).end();
  }
}, apiProxy);
app.listen(8099);
