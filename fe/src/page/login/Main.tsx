import React from "react";
import logo from "../../assets/nnzlogo.png";
import arrow from "../../assets/fast-forward.png";
import { Link } from "react-router-dom";

function Main() {
  return (
    <div className="flex flex-col items-center pt-40">
      <img src={logo} alt="로고" className="w-80 mb-3" />
      <div className="text-[#0d0d0d] mb-20 text-lg text-center">
        <p>안녕하세요</p>
        <p>나너주의 관리자 페이지입니다</p>
      </div>
      <div className="flex">
        <p className="mt-2 mr-3">로그인 하러가기</p>
        <Link to="/login">
          <img src={arrow} alt="화살표" className="w-10"></img>
        </Link>
      </div>
      <div className="text-base text-gray-500">
        문의는 어플을 통해 보내주세요
      </div>
    </div>
  );
}

export default Main;
