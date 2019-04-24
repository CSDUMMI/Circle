pragma solidity ^0.5.7;

contract Circle {
    
    
    struct Member {
        uint id;
        uint spendings;
        bool[] exspell_votes;
    }
    
    uint current_members;
    mapping (address => Member) members; // address => amount spend from the Circle
    
    
    modifier isMember {
        require(members[msg.sender].spendings > 0);
        _;
    }
    
    constructor(address [10] memory _members) public payable {
      for(uint i = 0;i < 10;i++) {
          members[_members[i]] = Member({id:i,spendings:1,exspell_votes:new bool[](10)});
      } 
    }
    
    function spend(uint _amount) public isMember {
        msg.sender.transfer(_amount);
        members[msg.sender].spendings += _amount;
    }
    
    function exspell(address _member) public isMember {
        require(members[_member].spendings > 0);
        members[_member].exspell_votes[members[msg.sender].id] = true;
        uint votes_to_exspell = 0;
        for(uint i = 0;i < 10; i++) {
            if(members[_member].exspell_votes[i]) {
                votes_to_exspell++;
            }
        }
        if(votes_to_exspell == current_members-1) {
            // All other members of the circle have
            // to agree to exspell one of their own.
            members[_member].spendings = 0; // hereby isMember doesn't recognize this as a Member anymore.
        }
    }
}

