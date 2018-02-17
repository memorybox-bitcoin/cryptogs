pragma solidity ^0.4.15;

contract SlammerTime {

  address public cryptogs;

  function SlammerTime(address _cryptogs) public {
    //deploy slammertime with cryptogs address coded in so
    // only the cryptogs address can mess with it
    cryptogs=_cryptogs;
  }

  function startSlammerTime(address _player1,uint256 _id1,address _player2,uint256 _id2) public returns (bool) {
    //only the cryptogs contract should be able to hit it
    require(msg.sender==cryptogs);

    Cryptogs cryptogsContract = Cryptogs(cryptogs);

    //make sure player1 owns _id1
    require(cryptogsContract.tokenIndexToOwner(_id1)==_player1);
    //transfer id1 in
    cryptogsContract.transferFrom(_player1,address(this),_id1);
    //make this contract is the owner
    require(cryptogsContract.tokenIndexToOwner(_id1)==address(this));


    //make sure player1 owns _id1
    require(cryptogsContract.tokenIndexToOwner(_id2)==_player2);
    //transfer id1 in
    cryptogsContract.transferFrom(_player2,address(this),_id2);
    //make this contract is the owner
    require(cryptogsContract.tokenIndexToOwner(_id2)==address(this));

    return true;
  }

  function transferBack(address _toWhom, uint256 _id) public returns (bool) {
    //only the cryptogs contract should be able to hit it
    require(msg.sender==cryptogs);

    Cryptogs cryptogsContract = Cryptogs(cryptogs);

    require(cryptogsContract.tokenIndexToOwner(_id)==address(this));
    cryptogsContract.transfer(_toWhom,_id);
    require(cryptogsContract.tokenIndexToOwner(_id)==_toWhom);
    return true;
  }


}



contract Cryptogs {
  mapping (uint256 => address) public tokenIndexToOwner;
  function transfer(address _to,uint256 _tokenId) external { }
  function transferFrom(address _from,address _to,uint256 _tokenId) external { }
}
