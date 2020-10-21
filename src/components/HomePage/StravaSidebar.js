import React from "react";
import {Card} from 'react-bootstrap';

const StravaSidebar = () => {
    return <Card className="side-panel strava">
        <Card.Header>Strava</Card.Header>
        <Card.Body>
		<iframe title="stravabar" allowtransparency="true" frameBorder ="0" height = "454" scrolling="no" src='https://www.strava.com/clubs/37924/latest-rides/962ac0041c05503286c8e79fb39538c4577229a0?show_rides=true' width= "100%"></iframe>
		</Card.Body>
    </Card>
};

export default StravaSidebar;