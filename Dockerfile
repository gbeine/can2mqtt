FROM golang:alpine

WORKDIR /usr/src/app

COPY . .
RUN cd src && go build -v -o /usr/local/bin/can2mqtt

ENV CAN2MQTT_CONFIG=/etc/can2mqtt.csv
ENV CAN2MQTT_INTERFACE=can0
ENV CAN2MQTT_MQTT=tcp://127.0.0.1:1883

CMD /usr/local/bin/can2mqtt -v -f $CAN2MQTT_CONFIG -c $CAN2MQTT_INTERFACE -m $CAN2MQTT_MQTT
