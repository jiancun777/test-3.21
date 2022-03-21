const Token = artifacts.require('Token');

module.exports = function (deployer) {
  deployer.deploy(Token).then(async () => {
    let instance = await Token.deployed();
    await instance.initialize(
      'TEST',
      'TEST',
      '0x8c1D43e0DfF7aD6d6b9993Fbb531a0dA1C635209',
      '0x940BC2E388b52d84E2dF2671a86082882f4Ea079'
    );
  });
};
