import { Link } from "react-router-dom";
import HeaderNav from "../../components/HeaderNav";
import axiosApi from "../../services/axiosApi";
import { useCallback, useEffect, useState } from "react";

function PerformHome() {
  const [requestData, setRequestData] = useState<perform[]>([]);

  interface perform {
    id: number;
    path: string;
    requester: string;
    title: string;
  }

  const listDataHandler = useCallback(async () => {
    try {
      const res = await axiosApi.get("admin-service/admin/ask/shows");
      console.log(res);
      setRequestData(res.data);
    } catch (err) {
      console.log(err);
    }
  }, []);

  // const listDataHandler = async () => {
  //   try {
  //     console.log(token);
  //     const res = await axiosApi.get("admin-service/admin/ask/shows");
  //     console.log(res);
  //   } catch (err) {
  //     console.log(err);
  //   }
  // };

  useEffect(() => {
    listDataHandler();
  }, [listDataHandler]);

  return (
    <div className="flex flex-col items-center">
      <div className="w-10/12">
        <HeaderNav />
        <div className="flex mt-32">
          <div className="w-1/5 bg-[#E7E7E7] mr-10 h-100 rounded mb-20">
            <div className="text-xl mb-12 pt-5 pl-5">공연 관리</div>
            <div className="text-right">
              <p className="mr-4 text-base">신청한 공연 관리</p>
            </div>
          </div>
          <div className="w-4/5 pt-10 pl-10 h-100 border-solid border-2 border-gray-400 rounded">
            <div className="text-xl text-left mb-10">신청 공연</div>
            <div className="flex flex-col items-center">
              {requestData.map((el) => (
                <div
                  key={el.id}
                  className="w-11/12 flex justify-between border-b-2 border-b-gray-300 text-base my-4"
                >
                  <p>
                    <Link
                      to={`${el.id}`}
                      state={{
                        id: el.id,
                        title: el.title,
                        requester: el.requester,
                        path: el.path,
                      }}
                    >
                      {el.title}
                    </Link>
                  </p>
                  <p>{el.requester}</p>
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default PerformHome;
