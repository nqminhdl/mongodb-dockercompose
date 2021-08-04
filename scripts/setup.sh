#!/bin/bash

MONGODB1=${LOCAL_IP}
MONGODB2=${LOCAL_IP}
MONGODB3=${LOCAL_IP}

echo "**********************************************"
echo "Waiting for startup.."
until curl http://mongo1:27017/serverStatus\?text\=1 2>&1 | grep uptime | head -1; do
  printf '.'
  sleep 1
done

# echo curl http://${MONGODB1}:28017/serverStatus\?text\=1 2>&1 | grep uptime | head -1
# echo "Started.."

mongo --host mongo1:27017 <<EOF
var cfg = {
    "_id": "rs0",
    "protocolVersion": 1,
    "version": 1,
    "members": [
        {
            "_id": 0,
            "host": "${MONGODB1}:27011",
            "priority": 2
        },
        {
            "_id": 1,
            "host": "${MONGODB2}:27012",
            "priority": 0
        },
        {
            "_id": 2,
            "host": "${MONGODB3}:27013",
            "priority": 0
        }
    ],settings: {chainingAllowed: true}
};
print(cfg);
rs.initiate(cfg, { force: true });
rs.reconfig(cfg, { force: true });
EOF

sleep 20

mongo --host mongo1:27017 <<EOF
use admin;
db.createUser({user:"boss", pwd:"boss", roles: ["root"]});
EOF
