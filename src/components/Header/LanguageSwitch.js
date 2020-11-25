import React from "react";
import {useTranslation} from "react-i18next";
import {Nav} from 'react-bootstrap';

const LanguageSwitch = () => {
    const {i18n} = useTranslation();
    let nextLanguage = 'en';
    if (i18n.language.indexOf('en') >= 0) {
        nextLanguage = 'nl'
    }
    console.log(nextLanguage);
    return <Nav.Link  onClick={() => i18n.changeLanguage(nextLanguage)}>
        <img style={{minWidth: 15}} src={`/assets/Site_${nextLanguage.toUpperCase()}.png`}/>
    </Nav.Link>
}

export default LanguageSwitch