import * as cowsay from "cowsay";
import { useEffect, useState } from 'react'
import './App.css'

function App() {
  const [msg, setMsg] = useState<string | undefined>(undefined);

  useEffect(() => {
    const msg = window.location.pathname.slice(1);
    fetch(`/api/dummy/${msg}`)
      .then(res => res.text())
      .then(res => setMsg(cowsay.say({ text: res })));
  }, []);

  return (
      <div className="card">
        {msg ?? 'Loading...'}
      </div>
  )
}

export default App
