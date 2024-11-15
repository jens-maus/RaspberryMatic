#!/bin/sh
tempio -conf /data/options.json -template /ha-proxy.js.gtpl -out /bin/ha-proxy.js
chmod a+rx /bin/ha-proxy.js
ls -la /usr/bin/node
ls -la /bin/ha-proxy.js
exec /usr/bin/node /bin/ha-proxy.js
