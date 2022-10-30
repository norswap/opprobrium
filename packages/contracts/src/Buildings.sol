// SPDX-License-Identifier: BSD-3-Clause-Clear

pragma solidity ^0.8.0;

import "./BuildingsData.sol";
import "./Mineral.sol";
import "./Gas.sol";
import "./Deuterium.sol";

import "@openzeppelin/access/Ownable.sol";

enum BuildingType {
    MINERAL_MINE,
    GAS_EXTRACTOR,
    DEUTERIUM_SYNTHESIZER
}

struct BuildingLevelInfo {
    uint32 costMineral;
    uint32 costGas;
    uint32 costDeuterium;
    uint32 productionRate;
    uint32 constructionTime;
}

contract Buildings is BuildingsData, Ownable {
    // Max level that buildings can be upgraded to.
    uint32 public constant MAX_LEVEL = 4;

    // Addresses for resource contracts.
    Deuterium public deuterium;
    Gas public gas;
    Mineral public mineral;

    // Whether the addresses have already been set.
    bool public initialized = false;

    // Maps (player, building type) to building level.
    mapping(address => mapping(BuildingType => uint32)) public levels;

    function productionRate(address player, BuildingType btype) public view returns (uint32) {
        uint32 level = levels[player][btype];
        return levelInfo[btype][level].productionRate;
    }

    function upgrade(address player, BuildingType btype) public {
        uint32 level = levels[player][btype];
        require(level < MAX_LEVEL, "building already at max level");
        BuildingLevelInfo memory info = levelInfo[btype][level];

        // flush production at previous level's rate
        mineral.updateBalance(player);
        gas.updateBalance(player);
        deuterium.updateBalance(player);

        // pay the costs
        mineral.burn(info.costMineral);
        gas.burn(info.costGas);
        deuterium.burn(info.costDeuterium);

        levels[player][btype] = level + 1;
    }

    function initialize(
        Deuterium _deuterium,
        Gas _gas,
        Mineral _mineral
    ) external onlyOwner {
        require(!initialized);
        deuterium = _deuterium;
        gas = _gas;
        mineral = _mineral;
        initialized = true;
    }
}
