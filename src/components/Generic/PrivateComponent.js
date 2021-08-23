import React, { useContext } from 'react';
import { authContext } from '../../utils/AuthContext';

const PrivateComponent = ({ children }) => {
    const { user } = useContext(authContext);
    return user ? children : null;
};

export default PrivateComponent;