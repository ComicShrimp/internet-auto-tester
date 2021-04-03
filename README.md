# Internet Speed

Tool for monitoring internet speed over time

By using this aplication, you are accepting speedtest terms

## Setup Guide

### 1. Configure variables

1. Copy the `.env.example` file to `.env`
2. Fill all variables
3. Open `config/datasource.yml` and fill the variables with the values of `.env`:
    - `token` with value of `INFLUX_TOKEN` in .env
    - `password` with value of `DOCKER_INFLUXDB_INIT_PASSWORD` in .env
    - `organization` with value of `INFLUXDB_INIT_ORG` in .env
    - `defaultBucket` with value of `INFLUXDB_INIT_BUCKET` in .env

### 2. Run the script

1. Use docker compose (`docker-copmpose up -d`) to run everything :)

## Variables

You can set some varibles to specify the way you want the test to run

- `INTERVAL` (Optional, default: 3600): Define the time to wait between tests in seconds
- `SERVER_ID` (Optional, default: automatic) : Define the server ID to test, if not set, the test will take "the best server" to test, but this is not always true.

To set the variables, uncomment the environment part in docker-compose and set the values

## References

https://github.com/jkehres/docker-compose-influxdb-grafana