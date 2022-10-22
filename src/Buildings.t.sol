// SPDX-License-Identifier: BSD-3-Clause-Clear
pragma solidity ^0.8.0;

import "./Buildings.sol";

import "forge-std/Test.sol";

contract BuildingsTests is Test {
    Buildings private buildings;
    Deuterium private deuterium;
    Gas private gas;
    Mineral private mineral;

    address private constant player = 0x00000000000000000000000000000000DeaDBeef;
    BuildingType private constant MINE = BuildingType.MINERAL_MINE;
    BuildingType private constant EXTRACTOR = BuildingType.GAS_EXTRACTOR;
    BuildingType private constant SYNTHESIZER = BuildingType.DEUTERIUM_SYNTHESIZER;

    function setUp() public {
        buildings = new Buildings();
        deuterium = new Deuterium(buildings);
        gas = new Gas(buildings);
        mineral = new Mineral(buildings);
    }

    modifier init() {
        buildings.initialize(deuterium, gas, mineral);
        _;
    }

    function testFailUpgradeNonInit() public {
        buildings.upgrade(player, MINE);
    }

    function testUpgrade() public init {
        assertEq(buildings.levels(player, MINE), 0);
        buildings.upgrade(player, MINE);
        assertEq(buildings.levels(player, MINE), 1);

        assertEq(buildings.levels(player, EXTRACTOR), 0);
        buildings.upgrade(player, EXTRACTOR);
        assertEq(buildings.levels(player, EXTRACTOR), 1);

        assertEq(buildings.levels(player, SYNTHESIZER), 0);
        buildings.upgrade(player, SYNTHESIZER);
        assertEq(buildings.levels(player, SYNTHESIZER), 1);

        // alternate upgrades on purpose

        buildings.upgrade(player, MINE);
        assertEq(buildings.levels(player, MINE), 2);

        buildings.upgrade(player, EXTRACTOR);
        assertEq(buildings.levels(player, EXTRACTOR), 2);

        buildings.upgrade(player, SYNTHESIZER);
        assertEq(buildings.levels(player, SYNTHESIZER), 2);
    }
}
