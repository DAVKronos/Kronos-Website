import React from "react";

//TODO Add sponsors either directly of from Rails url.
const Sponsors = () => {
    return <div>
	<div className="row sponsor-white">
        <div className="col-xs-4">
			<div className="sponsor-text">
			Sponsoren
			</div>
		</div>
		<div className="col-xs-4">
			<a href="https://reddropdesign.nl">
				<img alt="Red Drop Design" src={'/assets/sponsors/sponsor-rdd.PNG'} />
			</a>
		</div>
		<div className="col-xs-4">
			<a href="https://www.uitvaartverzekeringexpert.nl/">
				<img alt="UitvaartverzekeringExpert" src={'/assets/sponsors/sponsor-UVE.png'} />
			</a>
		</div>
    </div>
	<div className="row sponsor-white">
        <div className="col-xs-4">
			<a href="https://www.twenteinvest.nl/">
				<img alt="Twente Invest! Beter in Vastgoed!" src={'/assets/sponsors/sponsor-twenteinvest.jpg'} />
			</a>
		</div>
		<div className="col-xs-4">
			<a href="https://www.autoverzekering.nl/">
				<img alt="Autoverzekering vergelijken" src={'/assets/sponsors/sponsor-auto.png'} />
			</a>
		</div>
		<div className="col-xs-4">
			<a href="https://www.overstappen.nl/autoverzekering/">
				<img alt="Goedkope autoverzekering" src={'/assets/sponsors/sponsor-overstappen.jpg'} />
			</a>
		</div>
    </div>
	<div className="row sponsor-white">
        <div className="col-xs-4">
			<a href="https://www.easyswitch.nl/energie-vergelijken/">
				<img alt="energie vergelijken" src={'/assets/sponsors/sponsor-easyswitch.svg'} />
			</a>
		</div>
		<div className="col-xs-4">
			<a href="https://www.simonlydiscount.nl/sim-only-providers.html">
				<img alt="vergelijk alle sim only providers op SimOnlyDiscount!" src={'/assets/sponsors/sponsor-simonly.png'} />
			</a>
		</div>
		<div className="col-xs-4">
			<a href="https://www.tvexpert.nl/android/virtual-reality-vr-bril.html">
				<img alt="een virtual reality (vr) bril kopen? Bezoek de TvExpert!" className="center-block" src={'/assets/sponsors/sponsor-tvexpert.png'} />
			</a>
		</div>
    </div>
	<div className="row sponsor-white">
        <div className="col-xs-4">
			<a href="https://www.radiocontrolexpert.nl/rc/rc-tank.html">
				<img alt="een radiografisch bestuurbare (rc) tank kopen? Bezoek de RadioControlExpert!" className="center-block" src={'/assets/sponsors/sponsor-radiocontrol.png'} />
			</a>
		</div>
		<div className="col-xs-4">
			<a href="https://www.uitvaartverzekeringvergelijken.com">
				<img alt="uitvaartverzekeringvergelijken.com" src={'/assets/sponsors/sponsor-uitvaart.png'} />
			</a>
		</div>
		<div className="col-xs-4">
			<a href="https://swift.online/">
				<img alt="swift.online" height="128" className="center-block" src={'/assets/sponsors/sponsor-swift.png'} />
			</a>
		</div>
    </div>
	<div className="row sponsor-white">
        <div className="col-xs-4">
			<a href="http://www.breukersverhuur.nl">
				<img alt="Breukers verhuur" src={'/assets/sponsors/sponsor-breukers.jpg'} />
			</a>
		</div>
		<div className="col-xs-4">
			<a href="https://uitvaartverzekeringwijzer.net">
				<img alt="Uitvaartverzekeringwijzer.net" src={'/assets/sponsors/sponsor-uitvaartverzekeringwijzer.png'} />
			</a>
		</div>
    </div>
	</div>
};

export default Sponsors;