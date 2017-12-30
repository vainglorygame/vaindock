FROM rabbitmq:3-alpine

RUN rabbitmq-plugins enable --offline rabbitmq_management rabbitmq_web_stomp

COPY custom-rabbitmq.config /etc/rabbitmq/rabbitmq.config
COPY enabled_plugins /etc/rabbitmq/enabled_plugins
RUN chmod 666 /etc/rabbitmq/rabbitmq.config

COPY add_users.sh /pre_docker-entrypoint.sh
RUN chmod 755 /pre_docker-entrypoint.sh
ENTRYPOINT /pre_docker-entrypoint.sh

EXPOSE 15672 15674
