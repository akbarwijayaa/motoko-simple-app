import { useState } from 'react';
import { hello_backend } from 'declarations/hello_backend';

function App() {
  const [greeting, setGreeting] = useState('');

  function checkAddressByName(event) {
    event.preventDefault();
    const address = event.target.elements.address.value;
    hello_backend.getAddressByName(address).then((greeting) => {
      setGreeting(greeting);
    });
    return false;
  }

  return (
    <main>
      <img src="/logo2.svg" alt="DFINITY logo" />
      <br />
      <br />
      <form action="#" onSubmit={checkAddressByName}>
        <label htmlFor="name">Enter your address: &nbsp;</label>
        <input id="address" alt="Address" type="text" />
        <button type="submit">Click Me!</button>
      </form>
      <section id="greeting">{greeting}</section>
    </main>
  );
}

export default App;
