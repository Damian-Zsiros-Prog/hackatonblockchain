const ChatStorage = artifacts.require("ChatStorage");

module.exports = function (deployer) {
  deployer.deploy(ChatStorage);
};
