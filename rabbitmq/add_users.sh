#!/usr/bin/env bash
set -e

(
count=0;
# Execute list_users until service is up and running
until timeout 5 rabbitmqctl list_users >/dev/null 2>/dev/null || (( count++ >= 20 )); do sleep 1; done;
if ! rabbitmqctl list_users | grep updater > /dev/null
then
   # rabbitmqctl delete_user guest
   rabbitmqctl add_user web web
   rabbitmqctl set_permissions -p / web "^stomp-subscription-" "^stomp-subscription-" "^(amq.topic$|stomp-subscription-)"
   # read only amq.topic on host /, but allow stomp subscribe
   # services below: all allowed
   rabbitmqctl add_user updater updater
   rabbitmqctl set_permissions -p / updater ".*" ".*" ".*"
   rabbitmqctl add_user apigrabber apigrabber
   rabbitmqctl set_permissions -p / apigrabber ".*" ".*" ".*"
   rabbitmqctl add_user processor processor
   rabbitmqctl set_permissions -p / processor ".*" ".*" ".*"

   echo "setup completed"
else
   echo "already setup"
fi
) &

# Call original entrypoint
exec docker-entrypoint.sh rabbitmq-server $@
