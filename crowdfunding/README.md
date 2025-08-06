# Simple Crowdfunding on Stacks Blockchain

This project implements a simple crowdfunding smart contract in Clarity, designed to run on the Stacks blockchain using Clarinet.

---

## 📌 Contract: `crowdfunding.clar`

### Features:
- A manager can create a campaign with a funding goal and deadline.
- Contributors can send STX to support the campaign.
- If the goal is reached before the deadline, the manager can withdraw the funds.
- If the goal is not reached after the deadline, contributors can claim refunds.
- The manager can also disable the campaign to prevent further contributions.

---

## 🚀 Setup Instructions

### 1. Install Clarinet
```bash
curl -sSfL https://get.clarinet.io | sh
2. Clone this repository
bash
Copy
Edit
git clone https://github.com/yourusername/simple-crowdfunding.git
cd simple-crowdfunding
3. Check and build
bash
Copy
Edit
clarinet check
📂 Project Structure
bash
Copy
Edit
contracts/
  crowdfunding.clar    # Smart contract code
Clarinet.toml          # Project configuration
README.md              # Documentation
🧪 Functions
Function	Access	Description
create-campaign	Public	Initializes campaign (only once)
contribute	Public	Allows STX contribution
withdraw	Manager	Withdraws funds if goal met
claim-refund	Public	Contributors reclaim funds if goal not met
disable-campaign	Manager	Stops campaign from accepting new contributions

🛡 Security Considerations
Only the manager can withdraw or disable campaigns.

Contributions are disabled if deadline is passed or campaign is inactive.

Refunds are only possible after deadline if goal not met.

👨‍💻 Author
Hammed Yakub
