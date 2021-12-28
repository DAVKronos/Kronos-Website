import React from 'react';
import {useHistory} from 'react-router-dom';
import MonthSwitcher from "./MonthSwitcher";
import {Col, Row, Nav, Table} from "react-bootstrap";
import {useTranslation} from "react-i18next";

const parseQueryString = function (objName) {
    const str = window.location.search;
    const objURL = {};
    str.replace(
        new RegExp("([^?=&]+)(=([^&]*))?", "g"),
        function ($0, $1, $2, $3) {
            objURL[$1] = $3;
        }
    );
    return objURL[objName];
};

const CategorySwitcher = () => {
    let history = useHistory();

    const changeCategory = (loc,sex) => {
        let pathname = history.location.pathname;
        let search = '?loc='.concat(loc).concat('&sex=').concat(sex);
        history.push({
            pathname: pathname,
            search: search
        })
    }

    return <Nav variant="tabs">
        <Nav.Item>
            <Nav.Link active = {parseQueryString('loc') === 'out' && parseQueryString('sex') === 'male'} onClick={() => changeCategory('out','male')}>Men Outdoor</Nav.Link>
        </Nav.Item>
        <Nav.Item>
            <Nav.Link active = {parseQueryString('loc') === 'out' && parseQueryString('sex') === 'female'}onClick={() => changeCategory('out','female')}>Women Outdoor</Nav.Link>
        </Nav.Item>
        <Nav.Item>
            <Nav.Link active = {parseQueryString('loc') === 'in' && parseQueryString('sex') === 'male'}onClick={() => changeCategory('in','male')}>Men Indoor</Nav.Link>
        </Nav.Item>
        <Nav.Item>
            <Nav.Link active = {parseQueryString('loc') === 'in' && parseQueryString('sex') === 'female'}onClick={() => changeCategory('in','female')}>Women Indoor</Nav.Link>
        </Nav.Item>
    </Nav>
}

const Records = () => {
    const {t, i18n} = useTranslation('resultPage');
    const lang = i18n.language;
    let date = new Date();

    return (<React.Fragment>
        <Row>
            <Col md={12}>
                <h1>{t('header')}</h1>
            </Col>
        </Row>
        <Row className="row-margin">
            <Col md={12}>
                <MonthSwitcher date={date} />
            </Col>
        </Row>
        <Row style={{marginTop: '5px'}}>
            <Col md={12}>
                <CategorySwitcher />
            </Col>
        </Row>
        <Row>
            <Col md={12}>
                <RecordTable loc ={parseQueryString('loc')} sex = {parseQueryString('sex')}/>
            </Col>
        </Row>
    </React.Fragment>);
}

const RecordTable = (data) => {
    const loc = data.loc;
    const sex = data.sex;
    if (loc==='out' && sex==='male') {
        return <Table>
            <thead>
            <tr>
                <th>Onderdeel</th>
                <th>Prestatie</th>
                <th>Recordhouder</th>
                <th>Datum</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td><b>Looponderdelen</b></td>
                <td/>
                <td/>
                <td/>
            </tr>
            <tr>
                <td>100m</td>
                <td>10.81</td>
                <td>Guus van den Boom</td>
                <td>07-09-1997</td>
            </tr>
            <tr>
                <td>200m</td>
                <td>21.67</td>
                <td>Rogier Janssen</td>
                <td>20-07-2013</td>
            </tr>
            <tr>
                <td>400m</td>
                <td>49.48</td>
                <td>Maarten ten Ham</td>
                <td>20-05-1993</td>
            </tr>
            <tr>
                <td>800m</td>
                <td>1:52,44</td>
                <td>Pieter van Langen</td>
                <td>22-08-2003</td>
            </tr>
            <tr>
                <td>1500m</td>
                <td>3:55,43</td>
                <td>Harmen Hoek</td>
                <td>07-07-2017</td>
            </tr>
            <tr>
                <td>3000m</td>
                <td>8:31,6</td>
                <td>Henk Janssen</td>
                <td>29-06-1988</td>
            </tr>
            <tr>
                <td>5000m</td>
                <td>14:26,9</td>
                <td>Henk Janssen</td>
                <td>07-09-1988</td>
            </tr>
            <tr>
                <td>10000m</td>
                <td>30:20,1</td>
                <td>Henk Janssen</td>
                <td>05-09-1986</td>
            </tr>
            <tr>
                <td><b>Speciale looponderdelen</b></td>
                <td/>
                <td/>
                <td/>
            </tr>
            <tr>
                <td>110m Horden</td>
                <td>15,1</td>
                <td>Ruud Smit</td>
                <td>30-06-1973</td>
            </tr>
            <tr>
                <td>400m Horden</td>
                <td>54,77</td>
                <td>Arend-Jan Spierenburg</td>
                <td>26-07-2014</td>
            </tr>
            <tr>
                <td>3000m Steeplechase</td>
                <td>9:23,0</td>
                <td>Luuk Steenbergen</td>
                <td>03-09-1988</td>
            </tr>
            <tr>
                <td>1000m Snelwandelen</td>
                <td>6:52,17</td>
                <td>Thijs van Aalten</td>
                <td>24-10-2021</td>
            </tr>
            <tr>
                <td>Uurloop</td>
                <td>11881,00</td>
                <td>Fabian Pelgröm</td>
                <td>24-10-2021</td>
            </tr>
            <tr>
                <td><b>Technische onderdelen</b></td>
                <td/>
                <td/>
                <td/>
            </tr>
            <tr>
                <td>Hoogspringen</td>
                <td>2,01</td>
                <td>Ruud Smit</td>
                <td>03-06-1971</td>
            </tr>
            <tr>
                <td>Polsstokhoogspringen</td>
                <td>4,20</td>
                <td>Koen Joosse</td>
                <td>16-05-1990</td>
            </tr>
            <tr>
                <td>Verspringen</td>
                <td>6,75</td>
                <td>Roy van Zijl</td>
                <td>09-08-2020</td>
            </tr>
            <tr>
                <td>Hinkstapspringen</td>
                <td>14,41</td>
                <td>Roy van Zijl</td>
                <td>13-06-2021</td>
            </tr>
            <tr>
                <td>Kogelstoten</td>
                <td>13,22</td>
                <td>Oscar Noordman</td>
                <td>03-09-1995</td>
            </tr>
            <tr>
                <td>Discuswerpen</td>
                <td>45,00</td>
                <td>Oscar Noordman</td>
                <td>10-07-1996</td>
            </tr>
            <tr>
                <td>Kogelslingeren</td>
                <td>37,17</td>
                <td>Thijs Roskamp</td>
                <td>04-07-2021</td>
            </tr>
            <tr>
                <td>Speerwerpen</td>
                <td>60,01</td>
                <td>Hille Groendijk</td>
                <td>29-06-2013</td>
            </tr>
            <tr>
                <td>Tienkamp</td>
                <td>5969</td>
                <td>Koen Joosse</td>
                <td>30-05-1993</td>
            </tr>
            <tr>
                <td><b>Estafettes</b></td>
                <td/>
                <td/>
                <td/>
            </tr>
            <tr>
                <td>4x100m</td>
                <td>43,24</td>
                <td>Martijn de lange <br/>
                Gertjan Rijk <br/>
                Daniël Hofman <br/>
                Arjan Pathmamanoharan</td>
                <td>26-09-1999</td>
            </tr>
            <tr>
                <td>4x400m</td>
                <td>3:27,43</td>
                <td>Gertjan Rijk <br/>
                    Arjan Pathmamanoharan <br/>
                    Demian Pot <br/>
                    Daniël Hofman</td>
                <td>19-06-1998</td>
            </tr>
            <tr>
                <td>Zweedse estafette</td>
                <td>2:02,5</td>
                <td>Daniël Hofman <br/>
                    Gertjan Rijk <br/>
                    Demian Pot <br/>
                    Niels van der Aar</td>
                <td>03-10-1998</td>
            </tr>
            <tr>
                <td>Olympische estafette</td>
                <td>3:40,4</td>
                <td>Arjan Eggink<br/>
                    Ruben van Moppes <br/>
                    Daniël Hofman<br/>
                    Arjan Pathmamanoharan</td>
                <td>05-07-2000</td>
            </tr>
            </tbody>
        </Table>
    }
    if (loc==='out' && sex==='female') {
        return <Table>
            <thead>
            <tr>
                <th>Onderdeel</th>
                <th>Prestatie</th>
                <th>Recordhouder</th>
                <th>Datum</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td><b>Looponderdelen</b></td>
                <td/>
                <td/>
                <td/>
            </tr>
            <tr>
                <td>100m</td>
                <td>12.8</td>
                <td>Ingrid Stam</td>
                <td>30-06-1993</td>
            </tr>
            <tr>
                <td>200m</td>
                <td>26,06</td>
                <td>Merel Wevers</td>
                <td>26-05-2019</td>
            </tr>
            <tr>
                <td>400m</td>
                <td>58,10</td>
                <td>Merel Wevers</td>
                <td>16-06-2019</td>
            </tr>
            <tr>
                <td>800m</td>
                <td>2:16,7</td>
                <td>Merel Wevers</td>
                <td>15-05-2021</td>
            </tr>
            <tr>
                <td>1500m</td>
                <td>4:38,07</td>
                <td>Karin Gorter</td>
                <td>30-05-2008</td>
            </tr>
            <tr>
                <td>3000m</td>
                <td>10:08,32</td>
                <td>Renee Sijbesma</td>
                <td>18-09-2021</td>
            </tr>
            <tr>
                <td>5000m</td>
                <td>18:59,4</td>
                <td>Sophie Crommelinck</td>
                <td>23-06-2016</td>
            </tr>
            <tr>
                <td>10000m</td>
                <td>40:51,13</td>
                <td>Anneleen van Beek</td>
                <td>17-06-1995</td>
            </tr>
            <tr>
                <td><b>Speciale looponderdelen</b></td>
                <td/>
                <td/>
                <td/>
            </tr>
            <tr>
                <td>100m Horden</td>
                <td>14,59</td>
                <td>Marjolein Bolten</td>
                <td>07-07-2018</td>
            </tr>
            <tr>
                <td>400m Horden</td>
                <td>1:02,43</td>
                <td>Merel Wevers</td>
                <td>18-05-2019</td>
            </tr>
            <tr>
                <td>3000m Steeplechase</td>
                <td>11:28,67</td>
                <td>Martien Schaub</td>
                <td>05-07-2003</td>
            </tr>
            <tr>
                <td>1000m Snelwandelen</td>
                <td>8:38,32</td>
                <td>Dunya van Zanten</td>
                <td>24-10-2021</td>
            </tr>
            <tr>
                <td><b>Technische onderdelen</b></td>
                <td/>
                <td/>
                <td/>
            </tr>
            <tr>
                <td>Hoogspringen</td>
                <td>1,70</td>
                <td>Marjolein Bolten</td>
                <td>27-05-2018</td>
            </tr>
            <tr>
                <td>Polsstokhoogspringen</td>
                <td>2.90</td>
                <td>Marjolein Bolten</td>
                <td>08-09-2021</td>
            </tr>
            <tr>
                <td>Verspringen</td>
                <td>5,67</td>
                <td>Marjolein Bolten</td>
                <td>16-06-2018</td>
            </tr>
            <tr>
                <td>Hinkstapspringen</td>
                <td>11,21</td>
                <td>Marjolein Bolten</td>
                <td>27-05-2018</td>
            </tr>
            <tr>
                <td>Kogelstoten</td>
                <td>12,86</td>
                <td>Brenda Pouw</td>
                <td>20-05-2007</td>
            </tr>
            <tr>
                <td>Discuswerpen</td>
                <td>37,54</td>
                <td>Brenda Pouw</td>
                <td>24-06-2003</td>
            </tr>
            <tr>
                <td>Kogelslingeren</td>
                <td>30,64</td>
                <td>Nadia Lachkar</td>
                <td>13-06-2007</td>
            </tr>
            <tr>
                <td>Speerwerpen</td>
                <td>41,84</td>
                <td>Brenda Pouw</td>
                <td>15-09-2002</td>
            </tr>
            <tr>
                <td>Zevenkamp</td>
                <td>5115</td>
                <td>Marjolein Bolten</td>
                <td>07-07-2018</td>
            </tr>
            <tr>
                <td><b>Estafettes</b></td>
                <td/>
                <td/>
                <td/>
            </tr>
            <tr>
                <td>4x100m</td>
                <td>50,03</td>
                <td>Evelien van Houweling <br/>
                    Merel Wevers <br/>
                    Marjolein Bolten <br/>
                    Michelle van Dorth</td>
                <td>18-09-2021</td>
            </tr>
            <tr>
                <td>4x400m</td>
                <td>4:16,77</td>
                <td>Marjolein Bolten <br/>
                    Annabel Boonman <br/>
                    Floor Stefess <br/>
                    Merel Wevers</td>
                <td>16-06-2019</td>
            </tr>
            <tr>
                <td>Zweedse estafette</td>
                <td>2:29,8</td>
                <td>Agens Mewe <br/>
                    Maaike Konter <br/>
                    Monique Hoogers <br/>
                    Annelies Braat</td>
                <td>15-09-2002</td>
            </tr>
            <tr>
                <td>Olympische estafette</td>
                <td>4:30,04</td>
                <td>Merel Wevers<br/>
                    Marjolein Bolten <br/>
                    Merel Lasschuijt<br/>
                    Michelle van Dorth</td>
                <td>08-09-2021</td>
            </tr>
            </tbody>
        </Table>
    }
    if (loc==='in' && sex==='male') {
        return <Table>
            <thead>
            <tr>
                <th>Onderdeel</th>
                <th>Prestatie</th>
                <th>Recordhouder</th>
                <th>Datum</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td><b>Looponderdelen</b></td>
                <td/>
                <td/>
                <td/>
            </tr>
            <tr>
                <td>60m</td>
                <td>6,8</td>
                <td>Guus van den Boom</td>
                <td>25-02-1996</td>
            </tr>
            <tr>
                <td>200m</td>
                <td>21.90</td>
                <td>Rogier Janssen</td>
                <td>15-12-2013</td>
            </tr>
            <tr>
                <td>400m</td>
                <td>50,78</td>
                <td>Ronald Kuin</td>
                <td>28-02-2009</td>
            </tr>
            <tr>
                <td>800m</td>
                <td>1:56,92</td>
                <td>Arjen Eggink</td>
                <td>06-02-2000</td>
            </tr>
            <tr>
                <td>1500m</td>
                <td>4:06,1</td>
                <td>Reijer Klopman</td>
                <td>16-01-1998</td>
            </tr>
            <tr>
                <td>3000m</td>
                <td>8:51,45</td>
                <td>Boike Kropman</td>
                <td>25-01-1998</td>
            </tr>
            <tr>
                <td><b>Speciale looponderdelen</b></td>
                <td/>
                <td/>
                <td/>
            </tr>
            <tr>
                <td>60m Horden</td>
                <td>8,4</td>
                <td>Ton van den Boogaard</td>
                <td>20-01-1985</td>
            </tr>
            <tr>
                <td><b>Technische onderdelen</b></td>
                <td/>
                <td/>
                <td/>
            </tr>
            <tr>
                <td>Hoogspringen</td>
                <td>2,00</td>
                <td>Ruud Smit</td>
                <td>19-12-1971</td>
            </tr>
            <tr>
                <td>Polsstokhoogspringen</td>
                <td>4,10</td>
                <td>Ton van den Boogaard</td>
                <td>27-01-1985</td>
            </tr>
            <tr>
                <td>Verspringen</td>
                <td>6,65</td>
                <td>Roy van Zijl</td>
                <td>29-02-2020</td>
            </tr>
            <tr>
                <td>Hinkstapspringen</td>
                <td>14,29</td>
                <td>Roy van Zijl</td>
                <td>29-02-2020</td>
            </tr>
            <tr>
                <td>Kogelstoten</td>
                <td>13,64</td>
                <td>Oscar Noordman</td>
                <td>21-01-1996</td>
            </tr>
            <tr>
                <td>Zevenkamp</td>
                <td>3653</td>
                <td>Frans Vercraeye</td>
                <td>26-01-1974</td>
            </tr>
            <tr>
                <td><b>Estafettes</b></td>
                <td/>
                <td/>
                <td/>
            </tr>
            <tr>
                <td>4x200m</td>
                <td>1:37,11</td>
                <td>Daniël Krant <br/>
                    Arco Krijgsman <br/>
                    Sjoerd Pater <br/>
                    Fredo Schotanus</td>
                <td>24-04-2004</td>
            </tr>
            <tr>
                <td>4x400m</td>
                <td>3:44,15</td>
                <td>Jeroen de Groot <br/>
                    Rink Hallman <br/>
                    Marcel Fekkes <br/>
                    Fredo Schotanus</td>
                <td>22-01-2005</td>
            </tr>
            <tr>
                <td>4x800m</td>
                <td>8:27,00</td>
                <td>Erik Droog <br/>
                    Rink Hallman <br/>
                    Arjen Eggink <br/>
                    Marcel Fekkes</td>
                <td>22-01-2000</td>
            </tr>
            <tr>
                <td>Zweedse estafette</td>
                <td>Vacant</td>
                <td/>
                <td/>
            </tr>
            </tbody>
        </Table>
    }
    if (loc==='in' && sex==='female') {
        return <Table>
            <thead>
            <tr>
                <th>Onderdeel</th>
                <th>Prestatie</th>
                <th>Recordhouder</th>
                <th>Datum</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td><b>Looponderdelen</b></td>
                <td/>
                <td/>
                <td/>
            </tr>
            <tr>
                <td>60m</td>
                <td>8,23</td>
                <td>Monique Hoogers</td>
                <td>15-12-2001</td>
            </tr>
            <tr>
                <td>200m</td>
                <td>25,94</td>
                <td>Merel Wevers</td>
                <td>17-02-2019</td>
            </tr>
            <tr>
                <td>400m</td>
                <td>58,11</td>
                <td>Merel Wevers</td>
                <td>22-02-2020</td>
            </tr>
            <tr>
                <td>800m</td>
                <td>2:21,24</td>
                <td>Merel Wevers</td>
                <td>03-02-2019</td>
            </tr>
            <tr>
                <td>1500m</td>
                <td>4:49,36</td>
                <td>Karin Gorter</td>
                <td>15-03-2008</td>
            </tr>
            <tr>
                <td>3000m</td>
                <td>11:39,92</td>
                <td>Jenny Wassenaar</td>
                <td>24-01-2004</td>
            </tr>
            <tr>
                <td><b>Speciale looponderdelen</b></td>
                <td/>
                <td/>
                <td/>
            </tr>
            <tr>
                <td>60m Horden</td>
                <td>9,13</td>
                <td>Marjolein Bolten</td>
                <td>03-02-2019</td>
            </tr>
            <tr>
                <td><b>Technische onderdelen</b></td>
                <td/>
                <td/>
                <td/>
            </tr>
            <tr>
                <td>Hoogspringen</td>
                <td>1,68</td>
                <td>Marjolein Bolten</td>
                <td>11-02-2018</td>
            </tr>
            <tr>
                <td>Polsstokhoogspringen</td>
                <td>2,20</td>
                <td>Karin Gorter</td>
                <td>08-03-2003</td>
            </tr>
            <tr>
                <td>Verspringen</td>
                <td>5,52</td>
                <td>Marjolein Bolten</td>
                <td>02-03-2019</td>
            </tr>
            <tr>
                <td>Hinkstapspringen</td>
                <td>9,85</td>
                <td>Agnes Mewe</td>
                <td>06-02-2000</td>
            </tr>
            <tr>
                <td>Kogelstoten</td>
                <td>12,62</td>
                <td>Brenda Pouw</td>
                <td>27-01-2008</td>
            </tr>
            <tr>
                <td>Vijfkamp</td>
                <td>3630</td>
                <td>Merel Wevers</td>
                <td>03-02-2019</td>
            </tr>
            <tr>
                <td><b>Estafettes</b></td>
                <td/>
                <td/>
                <td/>
            </tr>
            <tr>
                <td>4x200m</td>
                <td>2:02,04</td>
                <td>Annelies Braat <br/>
                    Nelleke van der Ploeg <br/>
                    Jenny Wassenaar <br/>
                    Nienke Ruepert</td>
                <td>24-04-2004</td>
            </tr>
            <tr>
                <td>4x400m</td>
                <td>Vacant</td>
                <td/>
                <td/>
            </tr>
            <tr>
                <td>4x800m</td>
                <td>Vacant</td>
                <td/>
                <td/>
            </tr>
            <tr>
                <td>Zweedse estafette</td>
                <td>Vacant</td>
                <td/>
                <td/>
            </tr>
            </tbody>
        </Table>
    }
    return null;

}

export default Records