import { useEffect } from "react";
import HeaderNav from "../../components/HeaderNav";
import axiosApi from "../../services/axiosApi";

function ReportHome() {
  const dataHandler = async () => {
    try {
      const res = await axiosApi.get("admin-service/admin/ask/reports");
      console.log(res);
    } catch (err) {
      console.log(err);
    }
  };

  useEffect(() => {
    dataHandler();
  }, []);

  return (
    <div className="flex flex-col items-center">
      <div className="w-10/12">
        <HeaderNav />
        <div className="flex mt-32">
          <div className="w-1/5 bg-[#E7E7E7] mr-10 h-100 mb-20 rounded">
            <div className="text-xl mb-12 pt-5 pl-5">신고 관리</div>
            <div className="text-right">
              <p className="mr-4 text-base">전체 조회</p>
            </div>
          </div>
          <div className="w-4/5 pt-10 pl-10 h-100 mb-20 border-solid border-2 border-gray-400 rounded">
            <div className="text-xl text-left mb-5">전체 신고</div>
            <div className="flex flex-col items-center">
              <div className="w-11/12 flex border-b-2 border-b-gray-300 text-base my-4">
                <p>ㅇㅇㅇ 게시글 관련해서 00 유저 신고합니다 </p>
              </div>
              <div className="w-11/12 flex border-b-2 border-b-gray-300 text-base my-4">
                <p>ㅇㅇㅇ 게시글 관련해서 신고합니다 </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default ReportHome;
