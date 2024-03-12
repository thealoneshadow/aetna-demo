import React from "react";
import ReactDOM from "react-dom/client";
import "./index.css";
import App from "./App";
import { PublicClientApplication, EventType } from "@azure/msal-browser";
import { msalConfig } from "./Config";

console.log(msalConfig);
const msalInstance = new PublicClientApplication(msalConfig);
console.log(msalInstance);
console.log(msalInstance.getAllAccounts().length);
if (msalInstance.getAllAccounts().length > 0) {
  console.log(msalInstance.getAllAccounts()[0]);
  msalInstance.setActiveAccount(msalInstance.getAllAccounts()[0]);
}

msalInstance.addEventCallback((event) => {
  if (event.eventType === EventType.LOGIN_SUCCESS && event.payload.account) {
    const account = event.payload.account;
    msalInstance.setActiveAccount(account);
  }
});

const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(<App instance={msalInstance} />);
