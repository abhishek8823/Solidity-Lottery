pragma solidity ^0.8.0;

contract Lottery {
    address manager;
    address[] public players;

    uint lotteryTicket = 0.001 ether;
    uint maxPlayer = 10;
    
    constructor() {
        manager = msg.sender;
    }

    modifier onlyManger() {
        require(msg.sender == manager);
        _;
    }
            
    function _generateRandomNumber(uint _number) internal view onlyManger returns (uint) {
        return uint(keccak256(abi.encodePacked(block.timestamp, _number))) % maxPlayer;
    } 

    function pickWinner() public onlyManger {
        require(players.length == 10);
        require(msg.sender == manager);
        uint winner = _generateRandomNumber(12);
        payable(players[winner]).transfer(maxPlayer*lotteryTicket);
        delete players;
    }

    function buyTicket() public payable {
        require(players.length < 10);
        require(msg.value == lotteryTicket);
        players.push(msg.sender);

    }

    receive() external  payable {
    }
} 
//0x9ecEA68DE55F316B702f27eE389D10C2EE0dde84
//import "@chainlink/contracts/src/v0.6/VRFConsumerBase.sol";
