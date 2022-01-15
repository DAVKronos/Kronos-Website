import React from 'react';
import {useTranslation} from "react-i18next";


const MultiLanguageText = ({nl, en, renderFunction}) => {
    const {i18n} = useTranslation();
    const language = i18n.language.split('-')[0];
    let text = nl;
    if (language === 'nl') {
        text = nl;
    } else if (language === 'en') {
        text = en;
    }
    if (renderFunction) {
        return renderFunction(text);
    }
    return text; 
}

export default MultiLanguageText;