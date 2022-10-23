# include .env file and export its env vars
# (-include to ignore error if it does not exist)
-include .env

# Update dependencies
setup			:; make init-modules; make install-deps
init-modules	:; git submodule update --init --recursive
install-deps	:; pnpm install --frozen-lockfile
update-deps		:; pnpm install
