ARG ARG_NGINX_VERSION=1.22.1 
FROM debian:10 AS build-stage
ARG ARG_NGINX_VERSION
ENV NGINX_VERSION=$ARG_NGINX_VERSION
RUN apt update && apt install wget git tar -y
RUN wget https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz
RUN tar -zxvf nginx-${NGINX_VERSION}.tar.gz
RUN git clone https://github.com/vozlt/nginx-module-vts.git
RUN apt install gcc g++ make -y && apt install libpcre3-dev zlib1g-dev -y
RUN cd nginx-${NGINX_VERSION} \
    && ./configure --with-compat --add-dynamic-module=/nginx-module-vts \
    && make modules

FROM nginx:1.22.1
ARG ARG_NGINX_VERSION
ENV NGINX_VERSION=$ARG_NGINX_VERSION
COPY --from=build-stage /nginx-${NGINX_VERSION}/objs/ngx_http_vhost_traffic_status_module.so /etc/nginx/modules
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf
RUN apt-get update && apt-get install wget -y
RUN wget https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/v0.94.0/otelcol_0.94.0_linux_amd64.deb
RUN dpkg -i otelcol_0.94.0_linux_amd64.deb
COPY nginx-module-vts-metrics.yaml /etc/otelcol/config.yaml
COPY start.sh /start.sh
RUN chmod +x start.sh
CMD ["/start.sh"]