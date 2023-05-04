import { Link } from "react-router-dom";
import HeaderNav from "../../components/HeaderNav";
import allow from "../../assets/allow.png";
import reject from "../../assets/reject.png";

function PerformHome() {
  interface perform {
    title: string;
    isPass: boolean;
    index: number;
  }

  const performData: perform[] = [
    {
      title: "OOO공연",
      isPass: true,
      index: 1,
    },
    {
      title: "OOO2공연",
      isPass: false,
      index: 2,
    },
  ];

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
              {performData.map((el) => (
                <div
                  key={el.index}
                  className="w-11/12 flex justify-between border-b-2 border-b-gray-300 text-base my-4"
                >
                  <p>
                    <Link to={`${el.index}`}>{el.title}</Link>
                  </p>
                  {el.isPass ? (
                    <img src={allow} alt="맞" className="w-5 h-5 mr-5"></img>
                  ) : (
                    <img src={reject} alt="틀" className="w-5 h-5 mr-5"></img>
                  )}
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
