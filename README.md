# Internet Speed

Tool for monitoring internet speed over time

By using this aplication, you are accepting speedtest terms

## Variables

You can set some varibles to specify the way you want the test to run

- `INTERVAL` (Optional, default: 3600): Define the time to wait between tests in seconds
- `SERVER_ID` (Optional, default: automatic) : Define the server ID to test, if not set, the test will take "the best server" to test, but this is not always true.

To set the variables, uncomment the environment part in docker-compose and set the values