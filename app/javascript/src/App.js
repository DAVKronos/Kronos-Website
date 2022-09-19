import React from 'react';
import './App.scss';
import AuthProvider from "./utils/AuthContext";
import {QueryCache, ReactQueryCacheProvider} from "react-query";

import i18n from './utils/i18n.js';
import AppRouter from "./AppRouter";
import CookiesWarning from './components/Generic/CookiesWarning';

const queryCache = new QueryCache({
  defaultConfig: {
       queries: {
           refetchOnWindowFocus: false,
           },
     },
})

const EnvContext = React.createContext({});

console.log(i18n);
const App = (props) => {
  return <EnvContext.Provider value={props}><AuthProvider>
    <ReactQueryCacheProvider queryCache={queryCache}>
    <AppRouter/>
    <CookiesWarning/>
    </ReactQueryCacheProvider>
  </AuthProvider>
  </EnvContext.Provider>;
};

export {EnvContext}



export default App;