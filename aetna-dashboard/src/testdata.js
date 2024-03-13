import "./App.css";
import {
  AuthenticatedTemplate,
  UnauthenticatedTemplate,
  useMsal,
  MsalProvider,
} from "@azure/msal-react";
import { loginRequest } from "./Config";
import Tableau from "./Tableau";
import Navbar from "./Navbar/Navbar";

const WrappedView = () => {
  const { instance } = useMsal();
  const activeAccount = instance.getActiveAccount();

  const handleRedirect = () => {
    instance
      .loginRedirect({
        ...loginRequest,
        prompt: "create",
      })
      .catch((err) => console.log(err));
  };

  return (
    <div>
      <AuthenticatedTemplate>
        {activeAccount ? <p>Auth successful</p> : null}
      </AuthenticatedTemplate>
      <UnauthenticatedTemplate>
        <button onClick={handleRedirect} className="login-button">
          Login
        </button>
      </UnauthenticatedTemplate>
    </div>
  );
};

function App({ instance }) {
  return (
    <MsalProvider className="App" instance={instance}>
      <Navbar />
      <WrappedView />
      <Tableau />
    </MsalProvider>
  );
}

export default App;
