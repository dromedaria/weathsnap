# Trying to avoid weird side-effects of Make. Not yet sure details, but see:
#		https://wiki.hpcc.msu.edu/display/~colbrydi@msu.edu/2012/03/05/Makefile+Mystery
#		https://www.gnu.org/software/make/manual/html_node/Phony-Targets.html
# Without this, Make would always do "cat build.sh >build; chmod a+x build", whenever I did have a file called "build.sh".
.PHONY: build
# FOUND IT!  The case with *.sh files is due to "Implicit Rules" (aka Built-In Rules), specificaly added "for the benefit of SCCS".
#		https://www.gnu.org/software/make/manual/html_node/Catalogue-of-Rules.html#Catalogue-of-Rules

build:  make-image

# See section "With Apache" on this page: https://hub.docker.com/_/php/
make-image:
	docker build -t weathsnap-app .

# Whichever docker registry you set with "docker login" command
publish-image-docker-hub:
	docker tag weathsnap-app
	docker push weathsnap-app

# Public docker registry in Docker Hub. Amazon ECS FarGate does not support private docker registries other than than Amazon ECR.
publish-image-docker-hub-dromedaria:
	docker tag weathsnap-app dromedaria/weathsnap-app
	docker push dromedaria/weathsnap-app

