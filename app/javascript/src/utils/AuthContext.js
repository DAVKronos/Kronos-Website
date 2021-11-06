import React, { createContext, useState, useEffect } from 'react';
import {validateToken} from "./auth-helper";
import {getUser} from "../components/Users/queries";

export const authContext = createContext({});

const AuthProvider = ({ children }) => {
    const [user, setUser] = useState(null );

    const setUserData = (user) => {
        setUser(user);
    };

    useEffect(() => {
        validateToken().then((currentUser) => {
            if (currentUser) {
                getUser('users', currentUser.id).then((user) => {
                    setUser(user);
                })
            }
        })

    }, []);


    return (
        <authContext.Provider value={{ user, setUserData }}>
            {children}
        </authContext.Provider>
    );
};

export default AuthProvider;