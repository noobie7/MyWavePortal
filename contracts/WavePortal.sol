//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    mapping(address => uint256) waveCount;
    constructor(){
        console.log('Yo yo, I am a contract and I am smart');
    }
    
    function wave() public {
        totalWaves += 1;
        waveCount[msg.sender] += 1;
        console.log('%s has waved!!!', msg.sender);
    }

    function getTotalWaves() public view returns (uint256) {
        console.log('We have total %d number of waves!', totalWaves);
        return totalWaves;
    }

}