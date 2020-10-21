import React, { useContext } from 'react';
import { authContext } from '../utils/AuthContext';

const PrivateComponent = ({ children }) => {
    const { auth } = useContext(authContext);
    return auth.data ? children : null;
};

export default PrivateComponent;