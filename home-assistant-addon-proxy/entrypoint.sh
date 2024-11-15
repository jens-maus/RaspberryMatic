#!/bin/sh
tempio -conf /data/options.json -template /ha-proxy.js.gtpl -out /bin/ha-proxy.js
exec /bin/ha-proxy.js
