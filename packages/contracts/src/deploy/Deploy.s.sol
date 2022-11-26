// SPDX-License-Identifier: BSD-3-Clause-Clear
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../Buildings.sol";
import "../Deuterium.sol";
import "../Gas.sol";
import "../Mineral.sol";

contract DeployLocal is Script {
    function run() external {
        vm.startBroadcast();

        Buildings buildings = new Buildings();
        Deuterium deuterium = new Deuterium(buildings);
        Gas gas = new Gas(buildings);
        Mineral mineral = new Mineral(buildings);

        console2.log("Buildings address", address(buildings));
        console2.log("Deuterium address", address(deuterium));
        console2.log("Gas address", address(gas));
        console2.log("Mineral address", address(mineral));

        buildings.initialize(deuterium, gas, mineral);

        vm.stopBroadcast();
    }
}

contract DeployPublic is Script {
    bytes32 private constant salt = bytes32(uint256(4269));

    function run() external {
        vm.startBroadcast();

        // Using CREATE2 (specifying salt) makes deployment address predictable no matter the chain,
        // if the bytecode does not change. (Note that Foundry omits the matadata hash by default:
        // https://github.com/foundry-rs/foundry/pull/1180)

        // Not used for local deployments because it needs the CREATE2 deployer deployed at
        // 0x4e59b44847b379578588920ca78fbf26c0b4956c and that's not the case on the Anvil chain.

        Buildings buildings = new Buildings{salt: salt}();
        Deuterium deuterium = new Deuterium{salt: salt}(buildings);
        Gas gas = new Gas{salt: salt}(buildings);
        Mineral mineral = new Mineral{salt: salt}(buildings);

        console2.log("Buildings address", address(buildings));
        console2.log("Deuterium address", address(deuterium));
        console2.log("Gas address", address(gas));
        console2.log("Mineral address", address(mineral));

        buildings.initialize(deuterium, gas, mineral);

        vm.stopBroadcast();
    }
}
