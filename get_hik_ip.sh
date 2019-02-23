#!/bin/sh
per_ip=$(route -n | grep "^0.0.0.0" | awk '{print $2}' | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.')
for i in `seq 1 254`
do
  tmp_ip=$per_ip$i
  get_result=$(wget -q -O - "http://$tmp_ip/" --timeout=1 2>/dev/null | grep "/doc/page/login.asp")
  if [ -n "$get_result" ]; then
    echo $tmp_ip > /tmp/hik_ip.txt
    break
  fi
done
