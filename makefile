# Trying to avoid weird side-effects of Make. Not yet sure details, but see:
#		https://wiki.hpcc.msu.edu/display/~colbrydi@msu.edu/2012/03/05/Makefile+Mystery
#		https://www.gnu.org/software/make/manual/html_node/Phony-Targets.html
# Without this, Make would always do "cat build.sh >build; chmod a+x build", whenever I did have a file called "build.sh".
.PHONY: build
# FOUND THE PROBLEM!  The issue with *.sh files is due to "Implicit Rules" (aka Built-In Rules), specificaly one rule
# added "for the benefit of SCCS". To prevent this implicit rule's action, must use the above ".PHONY" rule.
#		https://www.gnu.org/software/make/manual/html_node/Catalogue-of-Rules.html#Catalogue-of-Rules

build:  make-image

# See section "With Apache" on this page: https://hub.docker.com/_/php/
make-image:
	docker build -t weathsnap-app .

# Whichever docker registry you set with "docker login" command
publish-image-docker-hub:
	docker tag weathsnap-app weathsnap-app:latest
	docker push weathsnap-app:latest

# Public docker registry in Docker Hub. Amazon ECS Fargate does not support private docker registries other than those in Amazon ECR.
publish-image-docker-hub-dromedaria:
	docker tag weathsnap-app dromedaria/weathsnap-app:latest
	docker push dromedaria/weathsnap-app:latest

