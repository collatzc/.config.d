#!/bin/sh

CONF_PATH=/etc/nginx/conf.d

for conf in $CONF_PATH/*.conf
do
  echo $conf
  ./nginxR.sh $conf
done

