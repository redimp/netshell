PLATFORM ?= "linux/arm64,linux/amd64"

run: build
	docker run -it --rm redimp/netshell:_build

dive: build
	dive redimp/netshell:_build

build:
	docker build \
		-f Dockerfile \
		-t redimp/netshell:_build \
		.

push:
	docker buildx build \
		--platform $(PLATFORM) \
		-f Dockerfile \
		-t redimp/netshell:latest \
		--push .

