import React from "react";
import baimage from "../assets/nnzBackground.png";
import logo from "../assets/nnzlogo.png";
import google from "../assets/google_play_logo 1.png";

import mock2 from "../assets/nnzmockup_5.png";
import mock3 from "../assets/nnzmockup_6.png";

function MainPage() {
  const navigateToGoogle = () => {
    window.open(
      "https://play.google.com/store/apps/details?id=com.nnz.nnz&hl=ko"
    );
  };
  return (
    <div className="">
      <img className="absolute h-screen w-full" src={baimage} alt="배경"></img>
      <div className="flex flex-col justify-items-center items-center w-full">
        <img src={logo} alt="로고" className="w-30 h-16 relative mt-7"></img>
        <div className="flex">
          <img src={mock2} alt="목업2" className="w-80 relative mt-12"></img>
          {/* <img src={mock3} alt="목업3" className="w-80 relative mt-12"></img> */}
        </div>
        <button
          className="relative mt-20 flex bg-[#4C4B4B] w-44 h-9 justify-items-center items-center rounded-sm opacity-75"
          onClick={navigateToGoogle}
        >
          <img src={google} alt="구스" className="w-10"></img>
          <p className="text-white text-sm">Google Play Store</p>
        </button>
      </div>
    </div>
  );
}

export default MainPage;
