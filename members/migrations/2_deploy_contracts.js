var members = artifacts.require(“members”);
module.exports = function(deployer) {
  deployer.deploy(members);
};
