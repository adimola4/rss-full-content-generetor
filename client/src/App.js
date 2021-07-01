import React from 'react';
import './App.css';
import ToastProvider from "./components/ToastProvider";


//components
import RssList from './components/RssList';

function App() {

  return (
      <div className="App">
      <ToastProvider>
      
        <div className="header col">
          <h1 className="title">Rss full content</h1>
            <h5 className="subtitle">Convert RSS URL to full content RSS URL. </h5>
        </div>
          <RssList />  
          </ToastProvider>
      </div>
  );
}

export default App;