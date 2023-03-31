docker-compose -f mongors.yml up -d

sleep 20

docker exec mongo1 /scripts/initialize-replicaset.sh