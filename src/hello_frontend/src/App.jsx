import { useState } from 'react';
import { hello_backend } from 'declarations/hello_backend';

function App() {
  const [greeting, setGreeting] = useState('');

  function setName(event) {
    event.preventDefault();
    const address = event.target.elements.address.value;
    const addressName = event.target.elements.addressName.value;
    hello_backend.setName(address, addressName).then((greeting) => {
      setGreeting(greeting);
    });
    return false;
  };

  function checkAddressByName(event) {
    event.preventDefault();
    const nameAddress = event.target.elements.nameAddress.value;
    hello_backend.getAddressByName(nameAddress).then((greeting) => {
      setGreeting(greeting);
    });
    return false;
  };

  function getBalanceAddressName(event){
    event.preventDefault();
    const name = event.target.elements.name.value;
    hello_backend.getBalanceByName(name).then((greeting) => {
      setGreeting(greeting);
    });
    return false;
  };

  function mintToken(event){
    event.preventDefault();
    const nameAddressMint = event.target.elements.nameAddressMint.value;
    hello_backend.mintByName(nameAddressMint).then((greeting) => {
      setGreeting(greeting);
    });
    return false;
  };

  return (
    <main>
      <h3>Set your name address!</h3>
      <form action="#" onSubmit={setName}>
        <label htmlFor="address">Enter your address: &nbsp;</label>
        <input id="address" alt="Address" type="Principal" />
        <label htmlFor="addressName">Enter your name: &nbsp;</label>
        <input id="addressName" alt="Name" type="text" />
        <button type="submit">Mintz!</button>
      </form>
      <section id="greeting">{greeting}</section>
      <h3>Check your address by your name!</h3>
      <form action="#" onSubmit={checkAddressByName}>
        <label htmlFor="nameAddress">Enter your name: &nbsp;</label>
        <input id="nameAddress" alt="Name" type="text" />
        <button type="submit">Check!</button>
      </form>
      <section id="greeting">{greeting}</section>
      <h3>Check your Balance by your name!</h3>
      <form action="#" onSubmit={getBalanceAddressName}>
        <label htmlFor="addressName">Enter your name address: &nbsp;</label>
        <input id="addressName" alt="Address" type="text" />
        <button type="submit">Click Me!</button>
      </form>
      <section id="greeting">{greeting}</section>
      <h3>Mint Token!</h3>
      <form action="#" onSubmit={mintToken}>
        <label htmlFor="nameAddressMint">Enter your name: &nbsp;</label>
        <input id="nameAddressMint" alt="Name" type="text" />
        <button type="submit">Click Me!</button>
      </form>
      <section id="greeting">{greeting}</section>
    </main>
  );

}

export default App;
