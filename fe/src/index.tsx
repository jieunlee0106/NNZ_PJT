import React from 'react';
import ReactDOM from 'react-dom/client';
import "./styles/app.css";
import App from './App';
import { BrowserRouter } from 'react-router-dom';
import reportWebVitals from './reportWebVitals';

const rootNode = document.getElementById('root');
if (!rootNode) throw new Error("Failed to find the root element");

ReactDOM.createRoot(rootNode).render(
  <BrowserRouter>
    <App></App>
  </BrowserRouter>,
);

reportWebVitals();

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals

