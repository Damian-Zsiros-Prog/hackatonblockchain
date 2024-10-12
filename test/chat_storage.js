const ChatStorage = artifacts.require("ChatStorage");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("ChatStorage", function (/* accounts */) {
  it("should assert true", async function () {
    await ChatStorage.deployed();
    return assert.isTrue(true);
  });
});
