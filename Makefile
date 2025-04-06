SHELL := /usr/bin/env bash -euo pipefail -c
.EXPORT_ALL_VARIABLES:

CONTAINER_IMAGE_NAME ?= galexrt/container-vlc
CONTAINER_IMAGE_TAG  ?= $(subst /,-,$(shell git rev-parse --abbrev-ref HEAD))
CONTAINER_ARCHES ?= linux/amd64,linux/arm64

RELEASE_TAG := v$(shell date +%Y%m%d-%H%M%S-%3N)

## Create and push a newly generated git tag to trigger a new automated CI run
release:
	git tag $(RELEASE_TAG)
	$(MAKE) container-crossbuild CONTAINER_IMAGE_TAG="$(RELEASE_TAG)"
	git push origin $(RELEASE_TAG)

## Build the container image
container-build:
	docker build \
		--build-arg BUILD_DATE="$(shell date -u +'%Y-%m-%dT%H:%M:%SZ')" \
		--build-arg VCS_REF="$(shell git rev-parse HEAD)" \
		-t ghcr.io/$(CONTAINER_IMAGE_NAME):$(CONTAINER_IMAGE_TAG) \
		.
	docker tag ghcr.io/$(CONTAINER_IMAGE_NAME):$(VERSION) quay.io/$(CONTAINER_IMAGE_NAME):$(CONTAINER_IMAGE_TAG)

container-push:
	docker push ghcr.io/$(CONTAINER_IMAGE_NAME):$(CONTAINER_IMAGE_TAG)
	docker push quay.io/$(CONTAINER_IMAGE_NAME):$(CONTAINER_IMAGE_TAG)

container-crossbuild-prepare:
	if ! docker buildx ls | grep -q container-builder; then \
		docker buildx create \
			--name container-builder \
			--driver docker-container \
			--bootstrap --use; \
	fi

container-crossbuild: container-crossbuild-prepare
	docker buildx build \
		--progress=plain \
		--platform $(CONTAINER_ARCHES) \
		--build-arg BUILD_DATE="$(shell date -u +'%Y-%m-%dT%H:%M:%SZ')" \
		--build-arg REVISION="$(shell git rev-parse HEAD)" \
		-t "ghcr.io/$(CONTAINER_IMAGE_NAME):$(CONTAINER_IMAGE_TAG)" \
		-t "quay.io/$(CONTAINER_IMAGE_NAME):$(CONTAINER_IMAGE_TAG)" \
		--push \
		.
