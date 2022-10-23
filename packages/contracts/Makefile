# include .env file and export its env vars
# (-include to ignore error if it does not exist)
-include .env

# Update dependencies
setup			:; make update-libs ; make install-deps
update-libs		:; git submodule update --init --recursive
install-deps	:; pnpm install --frozen-lockfile

# Build & test & deploy
build         	:; forge build
xclean        	:; forge clean
lint          	:; pnpm run lint
test          	:; forge test
test-gasreport 	:; forge test --gas-report
# test-fork     :; forge test --gas-report --fork-url ${ETH_NODE}
watch		  	:; forge test --watch src/
