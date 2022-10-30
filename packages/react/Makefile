serve:
	cd www && pnpx reload -b
.PHONY: serve

build:
	pnpx esbuild app.jsx --bundle --outdir=www
.PHONY: build

build-prod:
	pnpx esbuild app.jsx --bundle --minify --outdir=www
.PHONY: build-prod

watch:
	pnpx esbuild app.jsx --bundle --outdir=www --watch
.PHONY: watch
