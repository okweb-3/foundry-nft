// SPDXLicense-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "../lib/forge-std/src/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";


contract MintBasicNft is Script {
    string public constant Doodle = "https://raw2.seadn.io/ethereum/0x8a90cab2b38dba80c64b7734e58ee1db38b8992e/04cf3aa23639c708051b5020df0a535d.png";

    function run()  external {
       address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("BasicNft",block.chainid);

       mintNftOnContract(mostRecentlyDeployed);
    }
    function mintNftOnContract(address contractAddress)public{
        vm.startBroadcast();
        BasicNft(contractAddress).mintNft(Doodle);
        vm.stopBroadcast();
    }
}