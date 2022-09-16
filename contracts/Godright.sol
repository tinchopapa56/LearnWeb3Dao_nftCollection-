// SPDX-License-Identifier: MIT
  pragma solidity ^0.8.4;

  import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
  import "@openzeppelin/contracts/access/Ownable.sol";
  import "./IWhitelist.sol";

//video me quede en 40:52

contract Godright is ERC721Enumerable, Ownable{
    string _baseTokenURI;
    uint256 public _price= 0.01 ether;
    bool public _paused;

    uint256 public maxTokenIds = 20;
    uint256 public tokenIds; //la cantidad minada hasta ahora
    
    IWhitelist whitelist;
    bool public presaleStarted;
    uint256 public presaleEnded;

    modifier onlyWhenNotPaused {
        require(!_paused, "Contract currently paused");
        _;
    }

    constructor (string memory baseURI, address whitelistContract) ERC721("Godright", "GD"){
        _baseTokenURI = baseURI;
        whitelist = IWhitelist(whitelistContract);
    }


    function startPresale() public onlyOwner {
        presaleStarted = true;
        presaleEnded = block.timestamp + 5 minutes;
    }

    function presaleMint() public payable onlyWhenNotPaused {
        require(presaleStarted && block.timestamp < presaleEnded, "Presale not active (probably already finsihed or didn´t even started");
        require(whitelist.whitelistedAddresses(msg.sender), "You didn´t sign up in the whitelist");
        require(tokenIds < maxTokenIds, "all NFTs are sold-out");
        require(msg.value >= _price, "Ether Sent is not correct");
        
        tokenIds += 1;
        _safeMint(msg.sender, tokenIds);
    }

    function mint() public payable onlyWhenNotPaused {
        require(presaleStarted && block.timestamp >= presaleEnded, "Presale not available, probably already ended");
        require(tokenIds < maxTokenIds, "All NFTs were sold out");
        require(msv.value >= _price, "Ether sent is not corret (perhaps not enough)");
        _safeMint(msg.sender, tokenIds);
    }

    function _baseURI() internal view virtual override returns (string memory){
        return _baseTokenURI;
    }

    function setPaused(bool val) public onlyOwner {
        _paused = val;
    }

    function withdraw() public onlyOwner {
        address _owner = owner();
        uint256 amount = address(this).balance;
        (bool sent, ) = _owner.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }
    receive() external payable {}
    fallback() external payable {}
}


