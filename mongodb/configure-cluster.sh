#!/bin/bash

echo configure-cluster.sh will be running in 15 seconds.
sleep 15

mongosh "mongo1:27017" <<EOF
var config = 
{ 
    "_id": "dbrs", 
    "version": 1, 
    "members": [ 
        { 
            "_id": 1, 
            "host": "mongo1:27017", 
            "priority": 2
        }, 
        { 
            "_id": 2, 
            "host": "mongo2:27017", 
            "priority": 0 
        }, 
        { 
            "_id": 3, 
            "host": "mongo3:27017", 
            "priority": 0 
        } 
    ]
};
rs.initiate(config, { force: true });
rs.status();

use admin;
db.createUser({ user: "dbadmin" , pwd: "dbadmin", roles: ["userAdminAnyDatabase", "dbAdminAnyDatabase", "readWriteAnyDatabase"]}); 
rs.status();
EOF
