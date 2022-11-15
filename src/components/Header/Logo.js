import React from "react";
import logonormal from '../../images/logonormal.png';
import logowide from '../../images/logowide.png'
// TODO very basic, does not always work, mobile ready?
const Logo = () => {
  return (
    <div className="logo-container">
      <div
        className="logo-top d-none d-lg-block"
        style={{
          background: `url(${logonormal}) no-repeat center`,
          backgroundSize: "contain",
        }}
      ></div>
      <div className="logo-top d-none d-md-block d-lg-none " style={{
          background: `url(${logowide}) no-repeat center`,
          backgroundSize: "contain",
        }} />
    </div>
  );
};

export default Logo;
