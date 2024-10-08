import Nat "mo:base/Nat";
import Principal "mo:base/Principal";
import Text "mo:base/Text";
import Map "mo:base/HashMap";

actor Token {
    var ledger : Map.HashMap<Principal, Nat> = Map.HashMap<Principal, Nat>(10, Principal.equal, Principal.hash);
    var _ledgerName : Map.HashMap<Principal, Text> = Map.HashMap<Principal, Text>(10, Principal.equal, Principal.hash);

    public query func getName(account : Principal) : async Text {
        switch (_ledgerName.get(account)) {
            case (?name) name;
            case null "Empty name";
        }
    };

    public func setName(account : Principal, accountName : Text) : async Text {
        let name = await getName(account);
        if (name == "Empty name"){
            _ledgerName.put(account, accountName);
            return "Minted name " # accountName # " to " # Principal.toText(account);
        };
        return "Nothing to do with " # accountName
        
    };

    public func deleteName(account : Principal) : async Text {
        let name = await getName(account);
        if (name != "Empty name"){
            _ledgerName.delete(account);
            return "Deleted name " # name # " from " # Principal.toText(account);
        };
        return "Nothing to do with " # name
        
    };

    public func mint(to : Principal, amount : Nat) : async Text {
        let balance = await getBalance(to);
        ledger.put(to, Nat.add(balance, amount));
        return "Minted " # Nat.toText(amount) # " tokens to " # Principal.toText(to);
    };

    public func mintByName(account : Text, amount : Nat) : async Text {
        let address: Text = await getAddressByName(account);
        let principal = Principal.fromText(address);

        let balance = await getBalance(principal);
        ledger.put(principal, Nat.add(balance, amount));
        return "Minted " # Nat.toText(amount) # " tokens to " # account;
    };

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

    public func transferByName(from : Text, to : Text, amount : Nat) : async Text {
        let fromAddress: Text = await getAddressByName(from);
        let toAddress: Text = await getAddressByName(to);

        let fromPrincipal = Principal.fromText(fromAddress);
        let toPrincipal = Principal.fromText(toAddress);

        let fromBalance = await getBalance(fromPrincipal);
        if (fromBalance < amount) {
            return "Insufficient balance";
        };

        ledger.put(fromPrincipal, Nat.sub(fromBalance, amount));
        let toBalance = await getBalance(toPrincipal);
        ledger.put(toPrincipal, Nat.add(toBalance, amount));

        return "Transferred " # Nat.toText(amount) # " tokens from " # from # " to " # to;
    };

    public query func getBalance(account : Principal) : async Nat {
        switch (ledger.get(account)) {
            case (?balance) balance;
            case null 0;
        }
    };

    public query func getBalanceByName(account : Text) :  async Nat {
        let entries = _ledgerName.entries();
        var address: Text = "";
        
        for (entry in entries) {
            switch (entry) {
                case (key, value) {
                    if (value == account){
                        address := Principal.toText(key);
                    };
                };
            };
        };
        
        let principalAddress = Principal.fromText(address);

        switch (ledger.get(principalAddress)) {
            case (?balance) balance;
            case null 0;
        }
    };

    public query func totalSupply() : async Nat {
        var total : Nat = 0;
        for ((_, balance) in ledger.entries()) {
            total := Nat.add(total, balance);
        };
        return total;
    };

    public query func getAddressByName(account : Text) : async Text {
        let entries = _ledgerName.entries();
        var address: Text = "";
        
        for (entry in entries) {
            switch (entry) {
                case (key, value) {
                    if (value == account){
                        address := Principal.toText(key);
                    };
                };
            };
        };
        
        return address;
    };

    

};
