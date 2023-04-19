We first need to have up and running grafana and influxdb dependencies. To do this run the statement below

```
docker compose -f k6.yml up grafana influxdb
```

Having installation done, we are good to go with running our customized scripts :)

```
docker compose -f k6.yml run k6 run /scripts/worker.js
```

You're free to go [Grafana Dashboard](http://localhost:3000/d/k6/k6-load-testing-results?orgId=1&refresh=5s)
