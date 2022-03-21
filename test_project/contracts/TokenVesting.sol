// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../../lib0.8/erc20/IERC20.sol";
import "../../lib0.8/erc20/SafeERC20.sol";
import "../../lib0.8/common/SafeMath.sol";

/**
 * @title TokenVesting
 * @dev A token holder contract that can release its token balance gradually like a
 * typical vesting scheme, with a cliff and vesting period. Optionally revocable by the
 * owner.
 */
contract TokenVesting {
    using SafeMath for uint256;
    using SafeERC20 for IERC20;

    event Released(uint256 amount);

    // token被释放后的受益人
    address public beneficiary;

    uint256 public cliff;
    uint256 public start;
    uint256 public duration;

    mapping(address => uint256) public released;

    /**
     * @dev Creates a vesting contract that vests its balance of any ERC20 token to the
     * _beneficiary, gradually in a linear fashion until _start + _duration. By then all
     * of the balance will have vested.
     * @param _beneficiary 获赠代币的受益人地址
     * @param _cliff duration in seconds of the cliff in which tokens will begin to vest
     * @param _duration token授予的持续时间，单位为秒
     */
    // 创建一个授予合同，将其任何ERC20令牌的余额授予受益人,逐渐以线性方式直到_start + _duration。
    // 到那时所有的剩余的部分将被授予。
    constructor(
        address _beneficiary, //接受通证投放的收益账户；
        uint256 _start, // 起始时间（Unix time），提示从什么时刻开始计时；------使用block.timestamp
        uint256 _cliff, // 断崖时间，例如“锁仓4年，1年之后一次性解冻25%”中的1年；------例如：10 days
        uint256 _duration //持续锁仓时间，例如“锁仓4年，1年之后一次性解冻25%”中的4年；--例如：30 days
    ) {
        require(_beneficiary != address(0));
        require(_cliff <= _duration);

        beneficiary = _beneficiary;
        duration = _duration;
        cliff = _start.add(_cliff);
        start = _start;
    }

    /**
     * @notice Transfers vested tokens to beneficiary.
     * @param token ERC20 token which is being vested
     */
    //传入token合约地址，代币释放函数
    function release(address token) public {
        //unreleased:未释放的
        uint256 unreleased = releasableAmount(token);

        require(unreleased > 0);
        //当前已经释放的金额，先提前将数值相加随后再safeTransfer，防止重入攻击
        released[token] = released[token].add(unreleased);
        //转到我的钱包地址：beneficiary
        IERC20(token).safeTransfer(beneficiary, unreleased);

        emit Released(unreleased);
    }

    /**
     * @dev Calculates the amount that has already vested but hasn't been released yet.
     * @param token ERC20 token which is being vested
     */
    //计算当前实际应该释放的金额=当前应该释放的总金额-已经释放的金额。sub减
    function releasableAmount(address token) public view returns (uint256) {
        //第一次释放时released[token]=0，第一次释放后released[token]就会记录数值参与计算
        return vestedAmount(token).sub(released[token]);
    }

    /**
     * @dev Calculates the amount that has already vested.
     * @param token ERC20 token which is being vested
     */
    //计算当前应该释放的总金额。mul乘，div除
    function vestedAmount(address token) public view returns (uint256) {
        //首先计算当前合约地址里的余额，会有取出，所以数值会改变(如果有人不小心将币打进合约地址会锁住,变成激励代币的一部分)
        uint256 currentBalance = IERC20(token).balanceOf(address(this));
        //代表所有的激励代币=合约地址的+已经释放的，第一次释放时released[token]=0，第一次释放后released[token]就会记录数值
        uint256 totalBalance = currentBalance.add(released[token]);

        if (block.timestamp < cliff) {
            return 0;
            //最终时间到期
        } else if (block.timestamp >= start.add(duration)) {
            return totalBalance;
        } else {
            //总激励代币*时间的比例，总激励代币要一直是最开始的总量(只能多不能少)
            return totalBalance.mul(block.timestamp.sub(start)).div(duration);
        }
    }
}
