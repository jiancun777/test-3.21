// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../../lib0.8/upgrable/Ownable.sol";
import "../../lib0.8/upgrable/ERC20Blacklist.sol";

import "./TokenVesting.sol";

contract Token is ERC20 {
    address[] public _minters;
    TokenVesting public adLockToken;
    TokenVesting public teamLockToken;

    // uint256 public constant MAX_SUPPLY = 10 * 1e8 * 1e18;

    function initialize(
        string memory name_,
        string memory symbol_,
        address dig_,
        address airdrop_
    ) public initializer {
        Ownable.__Ownable_init();
        ERC20.__ERC20_init(name_, symbol_);

        teamLockToken = new TokenVesting(
            msg.sender,
            block.timestamp,
            30 days,
            300 days
        );
        adLockToken = new TokenVesting(
            msg.sender,
            block.timestamp,
            30 days,
            150 days
        );

        _mint(msg.sender, 1 * 1e8 * 1e18);
        _mint(dig_, 7 * 1e8 * 1e18);
        _mint(airdrop_, 1 * 1e8 * 1e18);
        _mint(address(teamLockToken), 5 * 1e7 * 1e18);
        _mint(address(adLockToken), 5 * 1e7 * 1e18);
    }

    // owner should be timelock.
    function addMinter(address _to) external onlyOwner {
        _minters.push(_to);
    }

    modifier onlyMinter() {
        bool isMinter = false;
        for (uint256 i = 0; i < _minters.length; i++) {
            if (_minters[i] == _msgSender()) {
                isMinter = true;
                break;
            }
        }
        require(isMinter, "!IsMinter: caller is not from minter");
        _;
    }

    // function mint(address _to, uint256 _amount)
    //     external
    //     onlyMinter
    // {
    //     if (totalSupply() > MAX_SUPPLY) return;
    //     _mint(_to, _amount);
    // }

    function burn(address _from, uint256 _amount) external onlyMinter {
        _burn(_from, _amount);
    }
}
