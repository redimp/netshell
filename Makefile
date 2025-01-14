PLATFORM ?= "linux/arm64,linux/amd64"

run:
	docker build \
		-f Dockerfile \
		-t redimp/netshell:_build \
		.
	docker run -it --rm redimp/netshell:_build

push:
	docker buildx build \
		--platform $(PLATFORM) \
		-f Dockerfile \
		-t redimp/netshell:latest \
		--push .

