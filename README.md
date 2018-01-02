# weathsnap
Simple web app providing detailed weather/astronomical data from
nearby [Wunderground](https://www.wunderground.com/) stations.

## Development environment
1. Get API key from Wunderground:
   1. Create free account at https://www.wunderground.com/weather/api
   1. Under "Key Settings" you can get free developer API key
1. Configure your API key using one of these two methods:
   1. Create this file and put your API key in it:
      1. ./secrets/wunder-api-key
   1. Set this environment variable to your API key:
      1. WUNDER_API_KEY
1. You do not need to do any make or build. For development, this web app
can be run as-is inside
a Docker container based on the official Docker image for PHP.
Simply run this command
to start a docker container that will use your copies of the source code
from the "./src" directory. Run this from top-level of your repo clone.
   1. `docker run -d --rm -p 8050:80 --name weathsnap-app-dev -v "$PWD/src/":/var/www/html -v "$PWD/secrets/":/var/www/data/secrets php:5.6-apache`
   1. Next, open your web browser to http://localhost:8050/weathsnap.php
   1. Any edits you do to the source code under "src/" are immediately
   effective in this running container, since the container's volume points to
   your "src" directory.
   1. For more info, see section "With Apache > Without a Dockerfile" on
   this page: https://hub.docker.com/_/php/

## Production Environment
I build and deploy this app as a Docker container to Amazon ECS (Elastic Container Service),
using the new "Fargate" launch
type (compared to standard EC2 launch type).
[ECS Fargate was introduced in November 2017](https://aws.amazon.com/blogs/compute/aws-fargate-a-product-overview/),
and currently only supports public Docker registries or
private Docker registries that are in Amazon ECR (Elastic Container Registry).

## Current Limitations
1. Still only half-done.
1. The actual details are pretty limited at the moment, while I get the
infrastructure stuff in place. Adding more details should be straightforward.
1. For now, all locations are hardcoded to ones from my own area.
1. Only current weather/astronomical conditions, no forecasting.

