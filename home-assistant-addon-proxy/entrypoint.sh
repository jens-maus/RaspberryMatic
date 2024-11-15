#!/bin/sh
set -x
tempio -conf /data/options.json -template /ha-proxy.js.gtpl -out /bin/ha-proxy.js
chmod a+rx /bin/ha-proxy.js
ls -la /usr/bin/node
ls -la /bin/ha-proxy.js
ls -la /
ls -la /app/
exec /bin/ha-proxy.js
