//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Test} from "../lib/forge-std/src/Test.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;

    address public USER = makeAddr("user");
    string public constant Doodle = "https://raw2.seadn.io/ethereum/0x8a90cab2b38dba80c64b7734e58ee1db38b8992e/04cf3aa23639c708051b5020df0a535d.png";

    function setUp() public{
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }
    function testNameIsCorrect() public view{
        string memory expectedName = "Doogie";
        string memory acutualName  = basicNft.name();     
        assert( keccak256(abi.encodePacked(expectedName))== keccak256(abi.encodePacked(acutualName)));
    }
    function testCanMintAndHaveABalance()public{
        vm.prank(USER);
        basicNft.mintNft(Doodle);
        assert(basicNft.balanceOf(USER) == 1);
        assert(keccak256(abi.encodePacked(Doodle))==keccak256(abi.encodePacked(basicNft.tokenURI(0))));
    }
    

}
