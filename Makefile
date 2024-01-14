.PHONY: build
build:
	docker run -v ${PWD}:/app kronos-esbuild-dev
image:
	docker build -t kronos-esbuild-dev .
