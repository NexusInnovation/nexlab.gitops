import { useEffect, useState } from 'react'
import './App.css'

function App() {
  const [msg, setMsg] = useState<string | undefined>(undefined);

  useEffect(() => {
    fetch('/api/dummy/test')
      .then(res => res.text())
      .then(res => setMsg(res));
  }, []);

  return (
    <>
      <h1>Nexlab App Frontend</h1>
      <div className="card">
        {msg ?? 'Loading...'}
      </div>
    </>
  )
}

export default App
