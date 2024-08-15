// Importing the necessary modules
import Nat "mo:base/Nat";
import Principal "mo:base/Principal";
import Text "mo:base/Text";
import Map "mo:base/HashMap";  // Importing the Map module

// Defining the main actor (smart contract)
actor Token {
    // Defining the token ledger as a mutable hashmap where the key is a Principal (account) and the value is a Nat (balance)
    var ledger : Map.HashMap<Principal, Nat> = Map.HashMap<Principal, Nat>(10, Principal.equal, Principal.hash);

    // Minting new tokens to an account
    public func mint(to : Principal, amount : Nat) : async Text {
        let balance = await getBalance(to);
        ledger.put(to, Nat.add(balance, amount));
        return "Minted " # Nat.toText(amount) # " tokens to " # Principal.toText(to);
    };

    // Transferring tokens from one account to another
    public func transfer(from : Principal, to : Principal, amount : Nat) : async Text {
        let fromBalance = await getBalance(from);
        if (fromBalance < amount) {
            return "Insufficient balance";
        };
        ledger.put(from, Nat.sub(fromBalance, amount));
        let toBalance = await getBalance(to);
        ledger.put(to, Nat.add(toBalance, amount));
        return "Transferred " # Nat.toText(amount) # " tokens from " # Principal.toText(from) # " to " # Principal.toText(to);
    };

    // Checking the balance of an account
    public query func getBalance(account : Principal) : async Nat {
        switch (ledger.get(account)) {
            case (?balance) balance;
            case null 0;
        }
    };
    // Test Update
    // Retrieving the total supply of tokens (sum of all balances)
    public query func totalSupply() : async Nat {
        var total : Nat = 0;
        for ((_, balance) in ledger.entries()) {
            total := Nat.add(total, balance);
        };
        return total;
    };
};
