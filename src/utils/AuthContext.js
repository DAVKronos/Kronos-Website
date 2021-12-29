import React, { createContext, useState, useEffect } from 'react';
import {validateToken} from "./auth-helper";
import {getUser} from "../components/Users/queries";

export const authContext = createContext({});

const AuthProvider = ({ children }) => {
    const [user, setUser] = useState(null );
    const [loading, setLoading] = useState(true);

    const setUserData = (user) => {
        setUser(user);
    };

    useEffect(() => {
        validateToken().then((currentUser) => {
            setLoading(false);
            if (currentUser) {
                getUser('users', currentUser.id).then((user) => {
                    setUser(user);
                })
            }
        })

    }, []);


    return (
        <authContext.Provider value={{ user, setUserData }}>
            {!loading && children}
        </authContext.Provider>
    );
};

export default AuthProvider;