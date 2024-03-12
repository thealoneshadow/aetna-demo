import { LogLevel } from "@azure/msal-browser";

export const msalConfig = {
  auth: {
    clientId: "f4fb9185-466c-4642-b938-b13fb1c91d07",
    redirectedUri: "/",
    postLogoutRedirectUri: "/",
    authority:
      "https://login.microsoftonline.com/divyanshugoyal2307gmail.onmicrosoft.com",
    navigateToLoginRequestUrl: false,
  },
  cache: {
    cacheLocation: "sessionStorage",
    storeAuthStateInCookie: false,
  },
  system: {
    loggerOptions: {
      loggerCallback: (level, message, containsPii) => {
        if (containsPii) {
          return;
        }
        // eslint-disable-next-line default-case
        switch (level) {
          case LogLevel.Error:
            console.error(message);
            return;
          case LogLevel.Info:
            console.info(message);
            return;
          case LogLevel.Verbose:
            console.debug(message);
            return;
          case LogLevel.Warning:
            console.warn(message);
            return;
          default:
            return;
        }
      },
    },
  },
};

export const loginRequest = {
  scopes: ["user.read"],
};
