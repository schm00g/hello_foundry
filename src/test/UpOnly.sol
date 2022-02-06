pragma solidity ^0.8.0;

contract OwnerUpOnly {
  address public immutable owner;
  uint256 public count;

  constructor() {
    owner = msg.sender;
  }

  function increment() external {
    require(
      msg.sender == owner,
      "only the owner can increment the count"
    );
    count++;
  }
}

import "ds-test/test.sol";

interface CheatCodes {
  function prank(address) external;
}

contract OwnerUpOnlyTest is DSTest {
  CheatCodes cheats = CheatCodes(HEVM_ADDRESS);
  OwnerUpOnly upOnly;

  function setUp() public {
    upOnly = new OwnerUpOnly();
  }

  function testIncrementAsOwner() public {
    assertEq(upOnly.count(), 0);
    upOnly.increment();
    assertEq(upOnly.count(), 1);
  }

  function testFailIncrementAsNotOwner() public {
    cheats.prank(address(0));
    upOnly.increment();
  }
}
