# Crowdfunding Contract (Clarity - Stacks Blockchain)

## 📌 Description
A simple crowdfunding smart contract written in Clarity. A campaign manager can start a fundraising campaign by setting a funding goal and a deadline. Users can contribute STX tokens. If the funding goal is met before the deadline, the manager can withdraw the funds. If the goal is not met by the deadline, contributors can claim refunds.

---

## 🚀 Project Setup

### Requirements
- [Clarinet](https://docs.stacks.co/docs/clarity/clarinet-installation)
- Git

### Setup Commands

```bash
git clone <your-repo-url>
cd crowdfunding
clarinet check
clarinet test
🛠️ Contract Functions
create-campaign (target uint, end uint)
Initializes the campaign.

Can only be called once.

Sets the funding goal and deadline.

contribute
Allows users to contribute STX before the deadline.

Amount is determined from the transaction.

withdraw
Allows the campaign manager to withdraw all raised funds if the funding goal is met and the campaign is still within the deadline.

claim-refund
Allows contributors to claim refunds after the deadline if the funding goal was not met.

📄 Contract Variables
Variable	Description
manager	Campaign creator
goal	Funding target
deadline	Campaign deadline (block height)
total-raised	Total contributions
contributions	Map of contributor => amount

🧪 Testing
Tests should simulate:

Campaign creation

Valid and invalid contributions

Successful goal achievement and manager withdrawal

Missed goal and user refunds
