import React, { createContext, useState, useEffect } from 'react';
import {validateToken} from "./auth-helper";

export const authContext = createContext({});

const AuthProvider = ({ children }) => {
    const [user, setUser] = useState(null );

    const setUserData = (user) => {
        setUser(user);
    };

    useEffect(() => {
        validateToken().then((currentUser) => {
            setUser( currentUser);
        })

    }, []);


    return (
        <authContext.Provider value={{ user, setUserData }}>
            {children}
        </authContext.Provider>
    );
};

export default AuthProvider;