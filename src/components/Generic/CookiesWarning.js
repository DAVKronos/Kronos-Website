import React, { useState } from "react";

import { Navbar, Container, Button } from "react-bootstrap";
import { getLocalSettings, setLocalSettings } from "../../utils/local-settings";
import {useTranslation} from "react-i18next";

const CookiesWarning = () => {
    const {t} = useTranslation('homepage');
  const [hiddenState, setHiddenState] = useState(false);
  const hidden = getLocalSettings("cookieWarningHidden");
  if (hidden || hiddenState) {
    return null;
  }
  const hide = () => {
    setHiddenState(true);
    setLocalSettings('cookieWarningHidden', true)
  };

  return (
    <Navbar fixed="bottom" expand="lg" variant="light" bg="light">
      <Container>
      {t('cookiesMessage')}
        <Button onClick={hide}>OK</Button>
      </Container>
    </Navbar>
  );
};

export default CookiesWarning;
