import http from "k6/http";
import { sleep, check } from "k6";

export const options = {
  scenarios: {
    stress: {
      executor: "ramping-arrival-rate",
      timeUnit: "1s",
      preAllocatedVUs: 500,
      stages: [
        { duration: "2m", target: 10 },
        { duration: "5m", target: 10 }
      ],
    },
  },
};

export default function () {
  const BASE_URL = "http://host.docker.internal:5000";
  let responses = http.batch([
    ['GET', BASE_URL + '/api/v1/foo/10'],
    ['GET', BASE_URL + '/api/v1/foo/21'],
    ['GET', BASE_URL + '/api/v1/foo/32'],
    ['GET', BASE_URL + '/api/v1/foo/43']
  ]);
  
  check(responses[0], {
    'is status 404': (r) => r.status === 404,
  });
}
