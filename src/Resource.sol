// SPDX-License-Identifier: BSD-3-Clause-Clear

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {BuildingType, Buildings} from "./Buildings.sol";

abstract contract Resource is ERC20Burnable {
    Buildings public buildings;
    BuildingType public buildingType;

    constructor(
        Buildings buildings_,
        BuildingType buildingType_,
        string memory name,
        string memory symbol
    ) ERC20(name, symbol) {
        buildings = buildings_;
        buildingType = buildingType_;
    }

    // Maps players to the timestamp where their balance was last updated.
    mapping(address => uint256) private lastUpdate;

    // Update resource production based on building production since last update.
    function updateBalance(address player) public {
        uint256 last = lastUpdate[player];
        if (last == block.timestamp) return;
        uint256 rate = buildings.productionRate(player, buildingType);
        uint256 amount = (block.timestamp - last) * rate;
        last = block.timestamp;
        _mint(player, amount);
    }
}
