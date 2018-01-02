# weathsnap
Simple web app providing detailed weather/astronomical data from
nearby [Wunderground](https://www.wunderground.com/) stations.

## Development environment
1. First you need an API key from Wunderground.
   1. Get free account and API key from Wunderground:
      1. Create account at: https://www.wunderground.com/weather/api
      1. Under "Key Settings", you can get free developer API key.
   1. Configure WeathSnap to use your API key. Two choices for doing this:
      1. Put your key in a file:
         1. Create folder "secrets" at top-level of your repo clone, as sibling to folder "src".
         (The .gitignore file excludes this folder from git.)
         1. In that folder, put your API key in file "./secrets/wunder-api-key".
      1. Alternatively, you could put your key in an environment variable:
         1. WUNDER_API_KEY   (must be accessible to the container)
1. To run WeathSnap app locally in your development environment, you do not need to
do any make or build. This web app runs as-is inside
a Docker container that's based on the official Docker image for PHP.
   1. Run this command from top-level of your repo clone:
      1. `docker run -d --rm -p 8050:80 --name weathsnap-app-dev -v "$PWD/src/":/var/www/html -v "$PWD/secrets/":/var/www/data/secrets php:5.6-apache`
   1. Next, point your web browser to: http://localhost:8050/weathsnap.php
   1. Any edits you do to the source code under "src/" are immediately
   effective in this running container, since the container's volume points to
   your "src" directory.
   1. Reference: Sections on "With Apache > Without a Dockerfile" on
   this page: https://hub.docker.com/_/php/

## Production Environment
I built and deployed this app as a Docker container to Amazon ECS (Elastic Container Service),
using the new "Fargate" launch
type (compared to standard EC2 launch type).
[ECS Fargate was introduced in November 2017](https://aws.amazon.com/blogs/compute/aws-fargate-a-product-overview/),
and currently only supports public Docker registries or
private Docker registries that are in Amazon ECR (Elastic Container Registry).
Since the ECS container has a public IP address, I can access my copy
of the web app using mobile phone, tablet, etc.

## Current Limitations
1. Still only half-done.
1. The actual weather details are pretty limited at the moment, while I get the
infrastructure stuff in place. Adding more weather details should be straightforward.
1. For now, all locations are hardcoded to ones from my own area.
1. Only current weather/astronomical conditions are displayed, there's no forecasting yet.

