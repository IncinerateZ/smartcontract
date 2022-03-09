const BlockHead = artifacts.require('BlockHead');

module.exports = function (deployer) {
    deployer.deploy(BlockHead);
};
