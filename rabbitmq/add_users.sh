#!/usr/bin/env bash
(
if [[ $RABBITMQ_RECREATE_ON_STARTUP ]]; then
    echo "*** *** deleting all data *** ***"
    rm -r "/var/lib/rabbitmq/mnesia/rabbit@$(hostname)/"
fi
echo "*** *** waiting for rabbitmq *** ***"
until rabbitmqctl status &>/dev/null; do sleep 1; done
sleep 5
echo "*** *** creating users *** ***"
# rabbitmqctl delete_user guest
rabbitmqctl add_user web web
rabbitmqctl set_permissions -p / web "^stomp-subscription-" "^stomp-subscription-" "^(amq.topic$|stomp-subscription-)"
# read only amq.topic on host /, but allow stomp subscribe
# services below: all allowed
rabbitmqctl add_user bridge bridge
rabbitmqctl set_permissions -p / bridge ".*" ".*" ".*"
rabbitmqctl add_user apigrabber apigrabber
rabbitmqctl set_permissions -p / apigrabber ".*" ".*" ".*"
rabbitmqctl add_user sampler sampler
rabbitmqctl set_permissions -p / sampler ".*" ".*" ".*"
rabbitmqctl add_user processor processor
rabbitmqctl set_permissions -p / processor ".*" ".*" ".*"
rabbitmqctl add_user analyzer analyzer
rabbitmqctl set_permissions -p / analyzer ".*" ".*" ".*"
rabbitmqctl add_user cruncher cruncher
rabbitmqctl set_permissions -p / cruncher ".*" ".*" ".*"
echo "*** *** custom rabbitmq setup done. *** ***"
) &

exec docker-entrypoint.sh rabbitmq-server $@
