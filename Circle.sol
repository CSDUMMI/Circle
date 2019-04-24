pragma solidity ^0.5.7;

contract Circle {
    
    
    struct Member {
        uint id;
        uint spendings;
        bool[] exspell_votes;
    }
    mapping (address => Member) members; // address => amount spend from the Circle

    modifier isMember {
        require(members[msg.sender].spendings > 0);
        _;
    }
    
    constructor(address [10] memory _members) public {
      for(uint i = 0;i < 10;i++) {
          members[_members[i]] = Member({id:i,spendings:1,exspell_votes:new bool[](10)});
      } 
    }
    
    function spend(uint _amount) public isMember {
        msg.sender.transfer(_amount);
        members[msg.sender].spendings += _amount;
    }
}
