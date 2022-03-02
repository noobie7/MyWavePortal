//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;

    uint256 private seed;
    event NewWave(address indexed from, uint256 timestamp , string message);

    struct Wave {
        address waver;
        uint256 timestamp;
        string message;
    }

    Wave[] waves;
    mapping(address => uint256) waveCount;
    mapping(address => uint256) lastWavedAt;
    constructor() payable {
        console.log('Yo yo, I am a contract and I am smart and I can pay now!' );
        seed = (block.timestamp + block.difficulty) % 100;
    }
    
    function wave(string memory _message) public {
        
        require(lastWavedAt[msg.sender] + 30 seconds < block.timestamp, "You need to wait for atleast 15 min. since your last wave!");
        

        lastWavedAt[msg.sender] = block.timestamp;
        totalWaves += 1;
        waveCount[msg.sender] += 1;

        console.log('%s has waved!!! w/ message ', msg.sender, _message);
        
        waves.push(Wave(msg.sender, block.timestamp, _message));
        seed = (block.difficulty + block.timestamp + seed) % 100;
        emit NewWave(msg.sender, block.timestamp, _message);
        console.log("Random # generated: %d", seed);
        if(seed <= 50){
            uint256 prizeAmount = 0.001 ether;
            require(prizeAmount <= address(this).balance, "Insufficient balance");
            (bool success, ) = (msg.sender).call{value : prizeAmount}("");
            require(success, "Could not complete transaction");
        }
        
    }

    function getAllWaves() public view returns (Wave[] memory){
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        console.log('We have total %d number of waves!', totalWaves);
        return totalWaves;
    }

}