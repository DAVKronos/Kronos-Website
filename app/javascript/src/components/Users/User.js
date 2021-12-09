import React from "react";
import styles from "./User.scss"
import {Col, Row, Table, Image} from 'react-bootstrap';
import {getAPIHostUrl} from "../../utils/rest-helper";
import {format} from '../../utils/date-format';
import {UserTypeName} from "./UserType";
import {useQuery} from "react-query";
import {Can} from "../../utils/auth-helper";
import {getUser} from "./queries";
import {MembershipList} from "./Commission";

const User = (props) => {
    const id = props.match.params.id
    const { isLoading, data:user} = useQuery(['users',id], getUser);
    console.log(user)
    if (user){
        var date = new Date(user.birthdate);
        var created_at = new Date(user.created_at);
        return (<React.Fragment>
            <h1>{user.name}</h1>
            <Row>
                <Col>
                    <Table>
                        <tbody>
                            <tr>
                                <td>
                                    <b>Initialen</b>
                                </td>
                                <td>
                                    {user.initials}
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>Geboortedatum</b>
                                </td>
                                <td>
                                    {date.toLocaleDateString()}
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>Email</b>
                                </td>
                                <td>
                                    {user.email}
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>Lidtype</b>
                                </td>
                                <td>
                                    <UserTypeName id={user.user_type_id}/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>Telefoonnummer</b>
                                </td>
                                <td>
                                    {user.phonenumber}
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>Adres</b>
                                </td>
                                <td>
                                    {user.address}
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>Postcode</b>
                                </td>
                                <td>
                                    {user.postalcode}
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>Stad</b>
                                </td>
                                <td>
                                    {user.city}
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>Studie</b>
                                </td>
                                <td>
                                    {user.studie}
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>Instelling</b>
                                </td>
                                <td>
                                    {user.instelling}
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>Aanvang</b>
                                </td>
                                <td>
                                    {user.aanvang}
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>Geslacht</b>
                                </td>
                                <td>
                                    {user.sex}
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>Licentienummber</b>
                                </td>
                                <td>
                                    {user.licensenumber}
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>UnionCardnummer</b>
                                </td>
                                <td>
                                    {user.xtracard}
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>Papieren Kronometer</b>
                                </td>
                                <td>
                                    {user.papieren_kronometer.toString()}
                                </td>
                            </tr>
                            <Can I={'manage'} this='all'>
                                <tr>
                                    <td>
                                        <b>Bankrekeningnummer</b>
                                    </td>
                                    <td>
                                        {user.bank_account_number}
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <b>IBAN</b>
                                    </td>
                                    <td>
                                        {user.iban}
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <b>Toegevoegd op</b>
                                    </td>
                                    <td>
                                        {created_at.toLocaleDateString()}
                                    </td>
                                </tr>
                            </Can>
                            <tr>
                                <td>
                                    <b>Commissies</b>
                                </td>
                                <td>
                                    {user.commissions.map(c =>c.name).toString()}
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
        </React.Fragment>);
    }
    return null;
}

export default User;