pragma solidity ^0.5.7;

import ./Circle.sol;

contract Circles {
    mapping(address => bool) circles;

    constructor() public {}
    
    modifier isCircle {
        require(circles[msg.sender] == true);
        _;
    }
    
    function votes() public isCircle {}
    
    function propose() public isCircle {}
    
}
