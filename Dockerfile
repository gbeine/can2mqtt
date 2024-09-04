FROM golang:alpine as builder

WORKDIR /usr/src/app

COPY . .
RUN cd src && go build -v -o /usr/local/bin/can2mqtt

FROM alpine:latest

RUN set -eux; \
        apk add --no-cache \
                can-utils

COPY --from=builder /usr/local/bin/can2mqtt /usr/local/bin/can2mqtt

ENV CAN2MQTT_CONFIG=/etc/can2mqtt.csv
ENV CAN2MQTT_INTERFACE=can0
ENV CAN2MQTT_MQTT=tcp://127.0.0.1:1883

CMD /usr/local/bin/can2mqtt -v -f $CAN2MQTT_CONFIG -c $CAN2MQTT_INTERFACE -m $CAN2MQTT_MQTT
