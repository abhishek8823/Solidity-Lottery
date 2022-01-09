// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Lottery {
    address manager;
    address[] public players;

    uint lotteryTicket = 1;
    uint maxPlayer = 10;
    
   
    
    constructor() {
        manager = msg.sender;
    }

    modifier onlyManger() {
        require(msg.sender == manager);
        _;
    }
            
    function _generateRandomNumber() internal view onlyManger returns (uint) {
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players))) % maxPlayer;
    } 

    function pickWinner() public onlyManger returns (uint) {
        require(players.length == maxPlayer);
        uint winner = _generateRandomNumber();
        //payable(players[winner]).transfer(maxPlayer*lotteryTicket);
        delete players;
        return winner;        
    }

    function setLotteryTicket(uint _ticketPrice) external onlyManger {
        lotteryTicket = _ticketPrice;
    }

    function setMaxPlayer(uint _maxPlayer) external onlyManger {
        lotteryTicket = _maxPlayer;
    }

    function getLotteryTicketPrice() public view returns (uint) {
        return lotteryTicket;
    }

    function getMaxPlayer() public view returns (uint){
        return maxPlayer;
    }

    function getPlayer() public view returns (address[] memory) {
        return players;
    }
    
    function buyTicket() public payable{
        require(players.length < 10);
        require(msg.value == lotteryTicket);
        players.push(msg.sender);

    }
    
    receive() external payable {
        
    }
    
} 
//0x9ecEA68DE55F316B702f27eE389D10C2EE0dde84
//import "@chainlink/contracts/src/v0.6/VRFConsumerBase.sol";
