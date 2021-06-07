import React from "react";
import {useTranslation} from "react-i18next";
import {Nav} from 'react-bootstrap';
import flagNL from '../../images/Site_EN.png';
import flagEN from '../../images/Site_NL.png';

const LanguageSwitch = () => {
    const {i18n} = useTranslation();
    let nextLanguage = 'en';
    if (i18n.language.indexOf('en') >= 0) {
        nextLanguage = 'nl'
    }

    const image = nextLanguage === 'en' ? flagEN : flagNL;
    return <Nav.Link className='language-switch' onClick={() => i18n.changeLanguage(nextLanguage)}>
        <img style={{minWidth: 12}} src={image}/>
    </Nav.Link>
}

export default LanguageSwitch