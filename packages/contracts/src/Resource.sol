// SPDX-License-Identifier: BSD-3-Clause-Clear

pragma solidity ^0.8.0;

import "@openzeppelin/token/ERC20/extensions/ERC20Burnable.sol";
import {BuildingType, Buildings} from "./Buildings.sol";

abstract contract Resource is ERC20Burnable {
    Buildings public buildings;
    BuildingType public buildingType;

    constructor(
        Buildings _buildings,
        BuildingType _buildingType,
        string memory name,
        string memory symbol
    ) ERC20(name, symbol) {
        buildings = _buildings;
        buildingType = _buildingType;
    }

    // Maps players to the timestamp where their balance was last updated.
    mapping(address => uint256) private lastUpdate;

    // Update resource production based on building production since last update.
    function updateBalance(address player) external {
        uint256 last = lastUpdate[player];
        if (last == block.timestamp) return;
        uint256 rate = buildings.productionRate(player, buildingType);
        uint256 amount = (block.timestamp - last) * rate;
        last = block.timestamp;
        _mint(player, amount);
    }

    // The Buildings contract doesn't need allowances to burn.
    function systemBurnFrom(address player, uint256 amount) external {
        require(msg.sender == address(buildings));
        _burn(player, amount);
    }

    // Public mint function — only for testing.
    function mint(address player, uint256 amount) external {
        require(msg.sender == address(this));
        _mint(player, amount);
    }
}
