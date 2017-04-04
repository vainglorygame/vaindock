#!/usr/bin/env bash
set -e

(
echo "waiting for rabbitmq"
while ! rabbitmqctl list_users &> /dev/null
do
    sleep 1
done
if rabbitmqctl list_users | grep "web"
then
    echo "users already exist, exiting"
    exit 1
fi
echo "creating new users"
# rabbitmqctl delete_user guest
rabbitmqctl add_user web web
rabbitmqctl set_permissions -p / web "^stomp-subscription-" "^stomp-subscription-" "^(amq.topic$|stomp-subscription-)"
# read only amq.topic on host /, but allow stomp subscribe
# services below: all allowed
rabbitmqctl add_user bridge bridge
rabbitmqctl set_permissions -p / bridge ".*" ".*" ".*"
rabbitmqctl add_user apigrabber apigrabber
rabbitmqctl set_permissions -p / apigrabber ".*" ".*" ".*"
rabbitmqctl add_user processor processor
rabbitmqctl set_permissions -p / processor ".*" ".*" ".*"
rabbitmqctl add_user compiler compiler
rabbitmqctl set_permissions -p / compiler ".*" ".*" ".*"
echo "custom rabbitmq setup done."
) &

exec docker-entrypoint.sh rabbitmq-server $@
