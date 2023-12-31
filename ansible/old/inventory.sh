#!/bin/bash

app=$(yc compute instance get --name reddit-app-0 | grep -A1 one_to_one_nat | awk '/address/ {print $2}')
db=$(yc compute instance get --name reddit-db-0 | grep -A1 one_to_one_nat | awk '/address/ {print $2}')
#app=$(yc compute instance list | grep RUNNING | awk -F '|' '{print $6}' | awk '{$1=$1};1')

#app=
#db=

if [ "$1" == "--list" ]; then

cat<<EOF
{
  "all": {
    "children": ["app","db"]
  },
  "app": {
    "hosts": ["$app"]
  },
  "db": {
    "hosts": ["$db"]
  },
  "_meta": {
    "hostvars": {}
  }
}
EOF

elif [ "$1" == "--host" ]; then
  echo '{"_meta": {hostvars": {}}}'
else
  echo "{ }"
fi

exit 0
