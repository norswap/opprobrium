# include .env file and export its env vars
# (-include to ignore error if it does not exist)
-include .env

# See README.md for documentation.

build: src/BuildingsData.sol
	forge build
.PHONY: build

test: src/BuildingsData.sol
	forge test
.PHONY: test

test-gas: src/BuildingsData.sol
	forge test --gas-report
.PHONY: test-gas

watch: src/BuildingsData.sol
	forge test --watch src/
.PHONY: watch

test-fork: src/BuildingsData.sol
	forge test --gas-report --fork-url ${ETH_NODE}
.PHONY: test-fork

# Depends on all files in ../data/buildings
src/BuildingsData.sol: $(shell find ../data/buildings)
	cd ../data && make buildings

clean:
	forge clean
.PHONY: clean

# Solhint will run prettier (prettier plugin configured).
# It also reports more details about prettier violation than prettier itself.
lint-check:
	pnpm exec solhint --config ./.solhint.json "src/**/*.sol"
.PHONY: lint-check

lint:
	pnpm exec prettier --check "src/**/*.sol" --write
	pnpm exec solhint --config ./.solhint.json "src/**/*.sol" --fix
.PHONY: lint

# The 1337 chain id matches chain.localhost in RainbowKit.
anvil:
	anvil --chain-id 1337
.PHONY: anvil

deploy-local:
	@forge script src/deploy/Deploy.s.sol:DeployLocal \
		--fork-url http://localhost:8545 \
		--private-key $(PRIVATE_KEY0) \
		--broadcast \
		| grep "address " > out/deployment.txt
	@cat out/deployment.txt
	@node scripts/extract_contract_addresses.js \
		out/deployment.txt \
		> out/deployment.json
.PHONY: deploy-local
