// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract TankChain {
    uint8 public constant MAP_WIDTH = 10;
    uint8 public constant MAP_HEIGHT = 10;
    uint8 public constant MAX_HEALTH = 3;

    struct Tank {
        uint8 x;
        uint8 y;
        uint8 health;
        bool alive;
    }

    mapping(address => Tank) public tanks;
    address[] public players;

    modifier onlyPlayer() {
        require(tanks[msg.sender].alive, "You must register first");
        _;
    }

    function register(uint8 x, uint8 y) external {
        require(!tanks[msg.sender].alive, "Already registered");
        require(x < MAP_WIDTH && y < MAP_HEIGHT, "Out of bounds");

        tanks[msg.sender] = Tank(x, y, MAX_HEALTH, true);
        players.push(msg.sender);
    }

    function move(uint8 newX, uint8 newY) external onlyPlayer {
        require(newX < MAP_WIDTH && newY < MAP_HEIGHT, "Out of bounds");
        tanks[msg.sender].x = newX;
        tanks[msg.sender].y = newY;
    }

    function shoot(address target) external onlyPlayer {
        require(tanks[target].alive, "Target not alive");

        Tank storage shooter = tanks[msg.sender];
        Tank storage enemy = tanks[target];

        // Примитивная логика стрельбы: только по прямой линии (x или y совпадают)
        bool sameRow = shooter.y == enemy.y;
        bool sameCol = shooter.x == enemy.x;

        require(sameRow || sameCol, "Can only shoot in straight line");

        // Если стреляем — уменьшаем здоровье
        if (enemy.health > 0) {
            enemy.health -= 1;
            if (enemy.health == 0) {
                enemy.alive = false;
            }
        }
    }

    function getTank(address player) external view returns (Tank memory) {
        return tanks[player];
    }

    function getPlayers() external view returns (address[] memory) {
        return players;
    }
}
