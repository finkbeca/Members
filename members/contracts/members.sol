pragma solidity ^0.5.0;


//escrow gets money from sender
//buyer sends product
//sender gets product
//





contract members {
  mapping(address => bool) memberList;
  uint256 numOfMembers;
  mapping (uint256 => mapping (address => bool) ) haveVotedMembers;
  mapping (uint256 => mapping (address => bool) ) haveVoted;
  mapping (address => bool) proposed_member_list;
  mapping (address => bool) proposed_removals;
  mapping (address => bool) blacklist;
  mapping (uint256 => bool) proposalResult;
  uint256 memberVote;
  uint256 proposalVote;
  address public leader;

    constructor() public {
       memberList[msg.sender] = true;
       leader = msg.sender;
       numOfMembers++;
    }

    modifier isMember {
      require(msg.sender == leader);
        _;
    }

    function addMember( address proposed_member)  public isMember   {

        if(memberList[proposed_member] != true) {
            memberVote++;
            proposed_member_list[proposed_member] = true;
            voteYesOnMember(memberVote, proposed_member );
        }


    }

    function  voteYesOnMember  (uint256 _vote, address proposed_member) public {
        uint256 numVotes;
        if((proposed_member_list[proposed_member] = true) && (haveVotedMembers[_vote][msg.sender] = false)) {
          haveVotedMembers[_vote][msg.sender] = true;
          numVotes++;
          if(numVotes > (numOfMembers /2) ) {
              proposed_member_list[proposed_member] = false;
              memberList[proposed_member] = true;
              numVotes =0;
          }
        }

    }
    function removeMember (address _member) public isMember {
        if(memberList[_member] = true) {
            memberVote++;
            proposed_removals[_member]= true;
            removeMemberVote(memberVote, _member);
        }
    }
    function removeMemberVote (uint256 _vote, address _member) public {
        uint256 votesToRemove;
        if((memberList[_member] = true) && (proposed_removals[_member] = true) && (haveVotedMembers[_vote][msg.sender] = false)) {
            haveVotedMembers[_vote][msg.sender] = true;
            votesToRemove++;
            if(votesToRemove > ((numOfMembers*3)/4)) {
                proposed_removals[_member] = false;
                memberList[_member] = false;
                blacklist[_member] = true;
            }
        }

    }
    function proposeVote() public isMember {
        proposalVote++;
        voteYesOnProposal(proposalVote);
    }
    function voteYesOnProposal (uint256 _vote) public {
        uint256 propsalVoteCount;
        if(haveVoted[_vote][msg.sender] = false) {
          haveVoted[_vote][msg.sender] = true;
          propsalVoteCount++;
          if(propsalVoteCount > (numOfMembers/2)) {
              proposalResult[proposalVote] = true;
          }

        }
    }
}
