RELEASE_TAG := v$(shell date +%Y%m%d-%H%M%S-%3N)

build:
	docker build -t galexrt/vlc:latest .

release:
	git tag $(RELEASE_TAG)
	git push origin $(RELEASE_TAG)

release-and-build: build
	git tag $(RELEASE_TAG)
	docker tag galexrt/vlc:latest galexrt/vlc:$(RELEASE_TAG)
	git push origin $(RELEASE_TAG)
	docker push galexrt/vlc:$(RELEASE_TAG)
	docker push galexrt/vlc:latest
