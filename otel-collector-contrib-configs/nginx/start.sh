#!/bin/bash
/usr/bin/otelcol-contrib --config /etc/otelcol-contrib/config.yaml &
nginx -g "daemon off;"