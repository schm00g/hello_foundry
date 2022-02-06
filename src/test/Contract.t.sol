// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import "ds-test/test.sol";

contract ContractTest is DSTest {
    uint256 testNumber;
    
    function setUp() public {
        testNumber = 42;
    }

    function testNumberIs42() public {
        assertEq(testNumber, 42);
    }

    function testFailDecrement() public {
        assertEq(testNumber, 40); // expected to fail `testFail` prefix
    }

    function testExample() public {
        assertTrue(true);
    }
}
