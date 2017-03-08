# Docker Swarm Start the way , Can not to Build.

IMAGE = registry.aliyuncs.com/hydsoft/ddc-jenkins-slave:latest

Swarm_start:
	@docker stack deploy -c docker-compose.yml ddc_demo

Compose_start:
	@docker-compose -f docker-compose.tml up -d

Compose_build:
	@docker-compose -f docker-compose.tml build

Jenkins_Slave_Build:
	@docker build --rm --build-arg ORACLE_JDK_VERSION=8u121 --build-arg ORACLE_JDK_BUILD_NUMBER=b13 -t $(IMAGE) image/ddc-jenkins-server

Docker_Push:
	@docker push $(IMAGE)
