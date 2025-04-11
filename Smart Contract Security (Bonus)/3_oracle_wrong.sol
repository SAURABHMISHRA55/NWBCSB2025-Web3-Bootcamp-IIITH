contract VulnerableLending {
    IUniswapV2Pair public priceOracle; // 🛑 Uses Uniswap as an oracle (manipulatable)
    mapping(address => uint256) public depositedCollateral;
    
    constructor(address _oracle) {
        priceOracle = IUniswapV2Pair(_oracle);
    }

    function deposit() public payable {
        depositedCollateral[msg.sender] += msg.value;
    }

    function borrow(uint256 amount) public {
        uint256 ethPrice = getPrice(); // 🛑 Uses Uniswap price (attackable)
        require(ethPrice > 0, "Invalid price");
        
        uint256 collateralValue = depositedCollateral[msg.sender] * ethPrice;
        require(collateralValue >= amount * 2, "Not enough collateral");

        payable(msg.sender).transfer(amount); // Loan given to user
    }

    function getPrice() public view returns (uint256) {
        (uint112 reserve0, uint112 reserve1, ) = priceOracle.getReserves();
        return reserve1 / reserve0; // 🛑 Manipulatable price calculation
    }
}


⚠️ Attackers can set fake prices!
