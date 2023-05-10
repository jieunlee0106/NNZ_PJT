import React from "react";
import HeaderNav from "../../components/HeaderNav";
import { Link, useLocation } from "react-router-dom";
import axiosApi from "../../services/axiosApi";

function ReportDetail() {
  const location = useLocation();

  const rejectReportHandler = async () => {
    try {
      const res = await axiosApi.patch("admin-service/admin/ask/reports", {
        id: location.state.id,
        status: 2,
      });
      console.log(res);
    } catch (err) {
      console.log(err);
    }
  };

  const allowReportHandler = async () => {
    try {
      const res = await axiosApi.patch("admin-service/admin/ask/reports", {
        id: location.state.id,
        status: 1,
      });
      console.log(res);
    } catch (err) {
      console.log(err);
    }
  };
  return (
    <div className="flex flex-col items-center">
      <div className="w-10/12">
        <HeaderNav />
        <div className="flex mt-32">
          <div className="w-1/5 bg-[#E7E7E7] mr-10 h-96 mb-20 rounded">
            <div className="text-xl mb-12 pt-5 pl-5">공연 관리</div>
            <div className="text-right">
              <p className="mr-4 text-base">신청한 공연 관리</p>
            </div>
          </div>
          <div className="w-4/5 pt-10 pl-10 h-96 border-solid border-2 border-gray-400 rounded flex flex-col items-center">
            <div className="text-xl w-full mb-10">{location.state.reason}</div>
            <div className="w-11/12 flex text-base">
              <div>
                <p className="my-1">신청 날짜</p>
              </div>
              <div className="mx-16">
                <p className="my-1">
                  {location.state.date.slice(0, -9)}{" "}
                  {location.state.date.slice(-8)}
                </p>
              </div>
            </div>
            <div className="mt-28 flex">
              <button
                className="w-28 h-8 bg-[#689F38] flex text-white rounded mx-2 font-bold justify-between items-center"
                onClick={allowReportHandler}
              >
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  viewBox="0 0 24 24"
                  fill="currentColor"
                  className="w-6 h-6 ml-2"
                >
                  <path
                    fillRule="evenodd"
                    d="M19.916 4.626a.75.75 0 01.208 1.04l-9 13.5a.75.75 0 01-1.154.114l-6-6a.75.75 0 011.06-1.06l5.353 5.353 8.493-12.739a.75.75 0 011.04-.208z"
                    clipRule="evenodd"
                  />
                </svg>
                <p>승인</p>
                <p></p>
              </button>

              <button
                className="w-28 h-8 bg-[#FF6465] flex text-white rounded mx-2 font-bold justify-between items-center"
                onClick={rejectReportHandler}
              >
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  viewBox="0 0 24 24"
                  fill="currentColor"
                  className="w-6 h-6 ml-2"
                >
                  <path
                    fillRule="evenodd"
                    d="M5.47 5.47a.75.75 0 011.06 0L12 10.94l5.47-5.47a.75.75 0 111.06 1.06L13.06 12l5.47 5.47a.75.75 0 11-1.06 1.06L12 13.06l-5.47 5.47a.75.75 0 01-1.06-1.06L10.94 12 5.47 6.53a.75.75 0 010-1.06z"
                    clipRule="evenodd"
                  />
                </svg>
                <p>거절</p>
                <p></p>
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default ReportDetail;
