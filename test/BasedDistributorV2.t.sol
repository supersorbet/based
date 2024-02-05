import "forge-std/Test.sol";
import "../src/BasedDistributorV2.sol";
import "../src/libraries/IBoringERC20.sol";

contract MockToken is BoringERC20 {
    uint8 private _decimals = 18;

    constructor() BoringERC20("MockToken", "MTK") {
        _mint(msg.sender, 10000 * (10 ** uint256(_decimals)));
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }
}
contract BasedDistributorV2Test is Test {
    BasedDistributorV2 distributor;

    function setUp() public {
        rewardToken = new MockToken();
        distributor = new BasedDistributorV2(rewardToken);
        lpToken = new MockToken();
    }

    function testAdd() public {
        // Arrange
        uint256 allocPoint = 10;
        uint16 depositFeeBP = 100;
        uint256 harvestInterval = 1 days;

        // Act
        distributor.add(allocPoint, lpToken, depositFeeBP, harvestInterval);

        // Assert
        BasedDistributorV2.PoolInfo memory pool = distributor.poolInfo(0);
        assertEq(pool.lpToken, lpToken);
        assertEq(pool.allocPoint, allocPoint);
        assertEq(pool.depositFeeBP, depositFeeBP);
        assertEq(pool.harvestInterval, harvestInterval);
    }

    function setUp() public {
        distributor = new BasedDistributorV2();
        // Add setup logic here
    }

    function testAdd() public {
        // Arrange
        uint256 allocPoint = 10;
        IBoringERC20 lpToken; // Replace with actual LP token
        uint16 depositFeeBP = 100;
        uint256 harvestInterval = 1 days;

        // Act
        distributor.add(allocPoint, lpToken, depositFeeBP, harvestInterval);

        // Assert
        // Replace `expectedResult` with the expected result of the `add` function
        PoolInfo memory expectedResult; // Replace with actual expected result
        assertEq(distributor.poolInfo(0), expectedResult);
    }

    function testSet() public {
        // Arrange
        uint256 pid = 0;
        uint256 allocPoint = 20;
        bool withUpdate = true;

        // Act
        distributor.set(pid, allocPoint, withUpdate);

        // Assert
        // Replace `expectedResult` with the expected result of the `set` function
        PoolInfo memory expectedResult; // Replace with actual expected result
        assertEq(distributor.poolInfo(pid), expectedResult);
    }

    function testDeposit() public {
        // Arrange
        uint256 pid = 0;
        uint256 amount = 100;

        // Act
        distributor.deposit(pid, amount);

        // Assert
        // Replace `expectedResult` with the expected result of the `deposit` function
        UserInfo memory expectedResult; // Replace with actual expected result
        assertEq(distributor.userInfo(pid, msg.sender), expectedResult);
    }

    function testWithdraw() public {
        uint256 pid = 0;
        uint256 amount = 50;

        distributor.withdraw(pid, amount);

        UserInfo memory expectedResult;
        assertEq(distributor.userInfo(pid, msg.sender), expectedResult);
    }

    function testEmergencyWithdraw() public {
        uint256 pid = 0;

        distributor.emergencyWithdraw(pid);

        UserInfo memory expectedResult; 
        assertEq(distributor.userInfo(pid, msg.sender), expectedResult);
    }
}