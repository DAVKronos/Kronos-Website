import React from "react";
import {useTranslation} from "react-i18next";
import {Nav} from 'react-bootstrap';

const LanguageSwitch = () => {
    const {i18n} = useTranslation();
    let nextLanguage = 'en';
    if (i18n.language.indexOf('en') >= 0) {
        nextLanguage = 'nl'
    }
    return <Nav.Link className='language-switch' onClick={() => i18n.changeLanguage(nextLanguage)}>
        <img style={{minWidth: 12}} src={`../images/Site_${nextLanguage.toUpperCase()}.png`}/>
    </Nav.Link>
}

export default LanguageSwitch