import React, { useState } from "react";
import { Row, Col, Form, Button } from "react-bootstrap";
import {FieldControl} from "../Generic/FormField";

const ForgotPasswordPage = () => {
  const [email, setEmail] = useState(null);

  return (
    <React.Fragment>
      <Row>
        <Col>
          <h1>Forgot password</h1>
        </Col>
      </Row>
      <Row>
        <Col md={6}>
          <Form>
            <FieldControl
              type="text"
              placeholder={"Email"}
              value={email}
              setValue={(e) => setEmail(e.target.value)}
            />
            <Button>Reset password</Button>
          </Form>
        </Col>
      </Row>
    </React.Fragment>
  );
};

export default ForgotPasswordPage;
