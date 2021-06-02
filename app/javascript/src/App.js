import React from 'react';
import './App.scss';
import AuthProvider from "./utils/AuthContext";
import {QueryCache, ReactQueryCacheProvider} from "react-query";

import i18n from './utils/i18n.js';
import AppRouter from "./AppRouter";

const queryCache = new QueryCache({
  defaultConfig: {
       queries: {
           refetchOnWindowFocus: false,
           },
     },
})

console.log(i18n);
const App = () => {
  return <AuthProvider>
    <ReactQueryCacheProvider queryCache={queryCache}>
    <AppRouter/>
    </ReactQueryCacheProvider>
  </AuthProvider>;
};



export default App;