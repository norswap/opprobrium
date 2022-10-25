serve: build
	pnpx esbuild --servedir=www/

build:
	pnpx esbuild app.jsx --bundle --outdir=www

build-prod:
	pnpx esbuild app.jsx --bundle --minify --outdir=www

.PHONY: serve
