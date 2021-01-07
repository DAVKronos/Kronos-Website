import React from 'react';
import './App.scss';
import AuthProvider from "./utils/AuthContext";
import {QueryCache, ReactQueryCacheProvider} from "react-query";

import './utils/i18n.js';
import AppRouter from "./AppRouter";

const queryCache = new QueryCache({
  defaultConfig: {
       queries: {
           refetchOnWindowFocus: false,
           },
     },
})


const App = () => {
  return <AuthProvider>
    <ReactQueryCacheProvider queryCache={queryCache}>
    <AppRouter/>
    </ReactQueryCacheProvider>
  </AuthProvider>;
};



export default App;