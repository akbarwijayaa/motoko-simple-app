# Token Actor Documentation

The `Token` actor is a smart contract that serves as a simple token with capabilities to store token balances, transfer tokens between accounts, and assign names to specific accounts. This implementation uses a HashMap to store the ledger and account names.

## Variables

### `ledger: Map.HashMap<Principal, Nat>`
- **Description:** A map that stores the token balance for each account identified by a `Principal`.
- **Type:** `Map.HashMap<Principal, Nat>`
- **Default:** A HashMap with an initial capacity of 10.

### `_ledgerName: Map.HashMap<Principal, Text>`
- **Description:** A map that stores the account name associated with each `Principal`.
- **Type:** `Map.HashMap<Principal, Text>`
- **Default:** A HashMap with an initial capacity of 10.

## Functions

### `getName(account : Principal) : async Text`
- **Description:** Returns the name associated with the given `Principal`.
- **Parameter:**
  - `account`: The Principal of the account whose name is to be retrieved.
- **Return:** The account name as `Text`, or "Empty name" if the name is not found.

### `setName(account : Principal, accountName : Text) : async Text`
- **Description:** Assigns a name to a specific account. If the account does not already have a name, the new name will be saved.
- **Parameter:**
  - `account`: The Principal of the account to be named.
  - `accountName`: The new name to be assigned to the account.
- **Return:** A message indicating whether the name was successfully saved or not.

### `mint(to : Principal, amount : Nat) : async Text`
- **Description:** Adds a certain amount of tokens to a specific account.
- **Parameter:**
  - `to`: The Principal of the account that will receive the tokens.
  - `amount`: The number of tokens to be added.
- **Return:** A message indicating the number of tokens that were minted.

### `mintByName(account : Text, amount : Nat) : async Text`
- **Description:** Adds a certain amount of tokens to an account based on the account name.
- **Parameter:**
  - `account`: The name of the account that will receive the tokens.
  - `amount`: The number of tokens to be added.
- **Return:** A message indicating the number of tokens that were minted to the account.

### `transfer(from : Principal, to : Principal, amount : Nat) : async Text`
- **Description:** Transfers a certain amount of tokens from one account to another.
- **Parameter:**
  - `from`: The Principal of the sender's account.
  - `to`: The Principal of the recipient's account.
  - `amount`: The number of tokens to be transferred.
- **Return:** A message indicating whether the transfer was successful or failed (e.g., due to insufficient balance).

### `transferByName(from : Text, to : Text, amount : Nat) : async Text`
- **Description:** Transfers a certain amount of tokens from one account to another based on the account names.
- **Parameter:**
  - `from`: The name of the sender's account.
  - `to`: The name of the recipient's account.
  - `amount`: The number of tokens to be transferred.
- **Return:** A message indicating whether the transfer was successful or failed.

### `getBalance(account : Principal) : async Nat`
- **Description:** Retrieves the token balance of a specific account.
- **Parameter:**
  - `account`: The Principal of the account whose balance is to be retrieved.
- **Return:** The token balance as `Nat`.

### `getBalanceByName(account : Text) : async Nat`
- **Description:** Retrieves the token balance of an account based on the account name.
- **Parameter:**
  - `account`: The name of the account whose balance is to be retrieved.
- **Return:** The token balance as `Nat`.

### `totalSupply() : async Nat`
- **Description:** Calculates the total token supply by summing all balances in the ledger.
- **Return:** The total token supply as `Nat`.

### `getAddressByName(account : Text) : async Text`
- **Description:** Retrieves the `Principal` (in text form) associated with a specific account name.
- **Parameter:**
  - `account`: The name of the account whose `Principal` is to be retrieved.
- **Return:** The `Principal` in text form as `Text`.
