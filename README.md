# 🛡️ TankChain: Onchain Battle Arena

**TankChain** is a fully on-chain PvP tank battle game built with Solidity.  
Players command tanks, move strategically on a grid battlefield, and shoot each other in a fight for survival — all on the blockchain.

---

## 🎮 Gameplay Overview

- 🚀 Register your tank with a starting position.
- 🎯 Move your tank around a 10x10 battlefield.
- 💥 Shoot opponents in straight lines (row or column).
- 💀 Reduce enemy health to 0 to eliminate them.
- 🧠 Fully on-chain logic — no off-chain tricks.

---

## 📜 Smart Contract

- Written in **Solidity `^0.8.24`**
- No external dependencies
- Deployable on any EVM-compatible chain

```solidity
function register(uint8 x, uint8 y) public;
function move(uint8 newX, uint8 newY) public;
function shoot(address target) public;
function getTank(address player) public view returns (Tank memory);
function getPlayers() public view returns (address[] memory);
