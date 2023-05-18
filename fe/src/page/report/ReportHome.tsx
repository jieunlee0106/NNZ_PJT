import { useCallback, useEffect, useState } from "react";
import HeaderNav from "../../components/HeaderNav";
import axiosApi from "../../services/axiosApi";
import { Link } from "react-router-dom";

interface reportsType {
  id: number;
  reason: string;
  reportedAt: string;
  reporterId: number;
  status: number;
  targetId: number;
}

function ReportHome() {
  const [reportData, setReportData] = useState<reportsType[]>([]);

  const reportDataHandler = useCallback(async () => {
    try {
      const token = await sessionStorage.getItem("accsesstoken");
      const res = await axiosApi.get("admin-service/admin/ask/reports", {
        headers: { Authorization: `Bearer ${token}` },
      });
      console.log(res);
      setReportData(res.data);
    } catch (err) {
      console.log(err);
    }
  }, []);

  useEffect(() => {
    reportDataHandler();
  }, [reportDataHandler]);

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
              {reportData.map((el) => (
                <div
                  key={el.id}
                  className="w-11/12 flex border-b-2 border-b-gray-300 text-base my-4 justify-between"
                >
                  <Link
                    to={`${el.id}`}
                    state={{
                      id: el.id,
                      reason: el.reason,
                      date: el.reportedAt,
                    }}
                  >
                    <p>{el.reason}</p>
                  </Link>
                  <p>
                    {el.reportedAt.slice(0, -9)} {el.reportedAt.slice(-8)}
                  </p>
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default ReportHome;
