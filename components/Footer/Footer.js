import React from "react";
import Contact from "./Contact";
import Sponsors from "./Sponsors";

// TODO add margin to main content
const Footer = () => {
    return <footer className="app">
		<div className="container">
        <Sponsors />
        <Contact />
		</div>
    </footer>
};

export default Footer;