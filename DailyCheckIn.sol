// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract DailyCheckIn {

    struct UserRecord {
        uint256 totalCheckIns;
        uint256 streak;
        uint256 lastCheckInDay;
    }

    mapping(address => UserRecord) public records;

    event CheckedIn(address indexed user, uint256 day, uint256 streak);

    function checkIn() external {
        uint256 today = block.timestamp / 1 days;

        UserRecord storage r = records[msg.sender];

        require(r.lastCheckInDay < today, "Already checked in today");

        if (r.lastCheckInDay == today - 1) {
            r.streak += 1;
        } else {
            r.streak = 1;
        }

        r.totalCheckIns += 1;
        r.lastCheckInDay = today;

        emit CheckedIn(msg.sender, today, r.streak);
    }

    function hasCheckedInToday(address user) external view returns (bool) {
        return records[user].lastCheckInDay == block.timestamp / 1 days;
    }
}
