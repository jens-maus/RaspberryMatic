FROM scratch

ARG TARGETARCH
ARG tar_prefix=rootfs

ADD $tar_prefix$TARGETARCH.tar /

LABEL org.opencontainers.image.title=RaspberryMatic \
      org.opencontainers.image.description="Alternative OS for your HomeMatic CCU" \
      org.opencontainers.image.vendor="RasperryMatic OpenSource Project" \
      org.opencontainers.image.authors="RaspberryMatic OpenSource Team" \
      org.opencontainers.image.licenses="Apache-2.0" \
      org.opencontainers.image.url="https://raspberrymatic.de" \
      org.opencontainers.image.source="https://github.com/jens-maus/RaspberyMatic" \
      org.opencontainers.image.documentation="https://github.com/jens-maus/RaspberryMatic/wiki" \
      io.hass.name="RaspberryMatic CCU" \
      io.hass.description="HomeMatic/homematicIP CCU central based on RaspberryMatic" \
      io.hass.url="https://github.com/jens-maus/RaspberyMatic/tree/master/home-assistant-addon" \
      io.hass.type=addon

HEALTHCHECK --interval=30s --timeout=30s --start-period=120s --retries=3 \
  CMD /bin/sh -c 'if [[ ! -S /var/run/monit.sock ]] || [[ $(/usr/bin/monit report initialising) != 0 ]]; then exit 2; fi; if [[ $(/usr/bin/monit report down) != 0 ]] && [[ ! -e /usr/local/HMLGW ]]; then exit 1; else exit 0; fi'

CMD ["/sbin/init"]
VOLUME /usr/local
EXPOSE 80 22 161 443 1900 1901 1902 5987 1999 2000 2001 2010 8088 8181 9099 9292 9293 10000 41999 42000 42001 42010 43438 43439 48181 48899 49292 49880
