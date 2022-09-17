import React from "react";
import { Col, Row, Table, Image, Button } from "react-bootstrap";
import { useTranslation } from "react-i18next";
import { UserTypeName } from "./UserType";
import { useQuery } from "react-query";
import { Can } from "../../utils/auth-helper";
import { getUser } from "./queries";
import { subject } from "@casl/ability";

import { Link, useHistory } from "react-router-dom";

const User = (props) => {
  const id = parseInt(props.match.params.id);
  const { isLoading, data: user } = useQuery(["users", id], getUser);
  const { t, i18n } = useTranslation("userpage");
  const lang = i18n.language;
  if (user) {
    var date = new Date(user.birthdate);
    var created_at = new Date(user.created_at);
    return (
      <React.Fragment>
        <h1>{user.name}</h1>
        <Row>
          <Col>
            <Table>
              <tbody>
                <tr>
                  <td>
                    <b>{t("initials")}</b>
                  </td>
                  <td>{user.initials}</td>
                </tr>
                <tr>
                  <td>
                    <b>{t("birthdate")}</b>
                  </td>
                  <td>{date.toLocaleDateString()}</td>
                </tr>
                <tr>
                  <td>
                    <b>E-mail</b>
                  </td>
                  <td>{user.email}</td>
                </tr>
                <tr>
                  <td>
                    <b>{t("membertype")}</b>
                  </td>
                  <td>
                    <UserTypeName id={user.user_type_id} />
                  </td>
                </tr>
                <tr>
                  <td>
                    <b>{t("phonenumber")}</b>
                  </td>
                  <td>{user.phonenumber}</td>
                </tr>
                <tr>
                  <td>
                    <b>{t("address")}</b>
                  </td>
                  <td>{user.address}</td>
                </tr>
                <tr>
                  <td>
                    <b>{t("postalcode")}</b>
                  </td>
                  <td>{user.postalcode}</td>
                </tr>
                <tr>
                  <td>
                    <b>{t("city")}</b>
                  </td>
                  <td>{user.city}</td>
                </tr>
                <tr>
                  <td>
                    <b>{t("study")}</b>
                  </td>
                  <td>{user.studie}</td>
                </tr>
                <tr>
                  <td>
                    <b>{t("institution")}</b>
                  </td>
                  <td>{user.instelling}</td>
                </tr>
                <tr>
                  <td>
                    <b>Start</b>
                  </td>
                  <td>{user.aanvang}</td>
                </tr>
                <tr>
                  <td>
                    <b>{t("sex")}</b>
                  </td>
                  <td>{user.sex}</td>
                </tr>
                <tr>
                  <td>
                    <b>{t("licensenumber")}</b>
                  </td>
                  <td>{user.licensenumber}</td>
                </tr>
                <tr>
                  <td>
                    <b>{t("unioncardnumber")}</b>
                  </td>
                  <td>{user.xtracard}</td>
                </tr>
                <tr>
                  <td>
                    <b>{t("paperkronometer")}</b>
                  </td>
                  <td>{user.papieren_kronometer.toString()}</td>
                </tr>
                <Can I={"manage"} this="User">
                  <tr>
                    <td>
                      <b>{t("banknumber")}</b>
                    </td>
                    <td>{user.bank_account_number}</td>
                  </tr>
                  <tr>
                    <td>
                      <b>IBAN</b>
                    </td>
                    <td>{user.iban}</td>
                  </tr>
                  <tr>
                    <td>
                      <b>{t("createdat")}</b>
                    </td>
                    <td>{created_at.toLocaleDateString()}</td>
                  </tr>
                </Can>
                <tr>
                  <td>
                    <b>{t("commissions")}</b>
                  </td>
                  <td>
                    {user.commissions
                      .map((c) => (lang === "nl" ? c.name : c.name_en))
                      .toString()}
                  </td>
                </tr>
              </tbody>
            </Table>
          </Col>
          <Col>
            <section className="polaroid">
              <figure>
                <Image src={user.avatar_url_medium} />
                <figcaption>{user.name}</figcaption>
              </figure>
            </section>
          </Col>
        </Row>
        <Row>
          <Col>
            <Can I="update" this={subject("User", user)}>
              <Button as={Link} to={`/users/${user.id}/edit`}>
                {t("generic:edit")}
              </Button>
            </Can>
            <Can I="editpassword" this={subject("User", user)}>
              <Button as={Link} to={`/users/${user.id}/password/edit`}>
                {t("changePassword")}
              </Button>
            </Can>
          </Col>
        </Row>
      </React.Fragment>
    );
  }
  return null;
};

export default User;
