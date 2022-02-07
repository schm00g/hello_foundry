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
  function expectRevert(bytes calldata) external;
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
    // prank cheatcode changed our identity to the zero address for the next call
    cheats.prank(address(0));
    upOnly.increment();
  }

  function testIncrementAsNotOwner() public {
    cheats.expectRevert(bytes("only the owner can increment the account"));
    cheats.prank(address(0));
    upOnly.increment();
  }
}
