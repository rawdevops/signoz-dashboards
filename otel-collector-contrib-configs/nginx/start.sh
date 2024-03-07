#!/bin/bash
/usr/bin/otelcol --config /etc/otelcol/config.yaml &
nginx -g "daemon off;"