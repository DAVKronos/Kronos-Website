.PHONY: build
watch:
	docker run -v ${PWD}:/app kronos-esbuild-dev node esbuild.js --watch
build:
	docker run -v ${PWD}:/app kronos-esbuild-dev
image:
	docker build -t kronos-esbuild-dev .
