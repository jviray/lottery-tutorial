pragma solidity ^0.4.17;

contract Lottery {
    address public manager;
    address[] public players;

    function Lottery() public {
        manager = msg.sender;
    }

    function enter() public payable {
        require(msg.value > .01 ether);

        players.push(msg.sender);
    }

    function pickWinner() public {
        // _random() is being called by this contract, not the address calling pickWinner
        uint index = _random() % players.length;

        // Addresses are object with a set of methods
        // Trasnfers money from current contract to the address calling the method
        players[index].transfer(this.balance);
    }

    function _random() private view returns (uint) {
      return uint(keccak256(block.difficulty, now, players));
    }
}
