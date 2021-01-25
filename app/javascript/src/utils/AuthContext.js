import React, { createContext, useState, useEffect } from 'react';

export const authContext = createContext({});

const AuthProvider = ({ children }) => {
    const [auth, setAuth] = useState({ loading: true, data: null });

    const setAuthData = (data) => {
        setAuth({data: data});
    };

    useEffect(() => {
        setAuth({ loading: false, data: JSON.parse(sessionStorage.getItem('user'))});
    }, []);


    return (
        <authContext.Provider value={{ auth, setAuthData }}>
            {children}
        </authContext.Provider>
    );
};

export default AuthProvider;