setup:
	make init-modules
	make install-deps
.PHONY: setup

init-modules:
	git submodule update --init --recursive
.PHONY: init-modules

install-deps:
	pnpm install --frozen-lockfile
.PHONY: install-deps

update-deps:
	pnpm install
.PHONY: update-deps
