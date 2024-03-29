// SPDX-License-Identifier: BSD-3-Clause-Clear

pragma solidity ^0.8.0;

import "./Resource.sol";
import {BuildingType} from "./Buildings.sol";

contract Deuterium is Resource {
    constructor(Buildings buildings) Resource(buildings, BuildingType.DEUTERIUM_SYNTHESIZER, "Deuterium", "DTRM") {}
}
