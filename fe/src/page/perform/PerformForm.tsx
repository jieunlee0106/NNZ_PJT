import { useState, useRef, useMemo, useEffect } from "react";
import HeaderNav from "../../components/HeaderNav";
import DatePicker from "react-datepicker";
import qs from "qs";

import "react-datepicker/dist/react-datepicker.css";
import { ko } from "date-fns/esm/locale";
import axiosApi from "../../services/axiosApi";
import useInput from "../../services/useInput";

axiosApi.defaults.paramsSerializer = (params) => {
  return qs.stringify(params);
};

interface category {
  code: string;
  name: string;
}

function PerformForm() {
  const [startDate, setStartDate] = useState(new Date());
  const [endDate, setEndDate] = useState(new Date());
  const title = useInput("");

  //사진
  const fileRef = useRef<HTMLInputElement>(null);
  const [imgSrcList, setImgSrcList] = useState<any | null>();
  const [imgUp, setImgUp] = useState<File>();

  //카테고리
  const [parcategory, setParCategory] = useState<category[]>([]);
  const categoryHandler = async () => {
    try {
      const res = await axiosApi.get("show-service/shows/categories");
      console.log(res);
      setParCategory(res.data);
    } catch (err) {
      console.log(err);
    }
  };
  //작은 카테고리
  const [smcategory, setSmCategofy] = useState<category[]>([]);
  const categorySelectHandler = async (
    event: React.ChangeEvent<HTMLSelectElement>
  ) => {
    const bigC = event.target.value;
    const params = { parent: bigC };
    try {
      const res = await axiosApi.get(`show-service/shows/categories`, {
        params,
      });
      console.log(res);
      setSmCategofy(res.data);
    } catch (err) {
      console.log(err);
    }
  };

  //지역
  const location: string[] = [
    "전국",
    "서울",
    "대학로",
    "홍대",
    "경기",
    "인천",
    "대전",
    "대구",
    "광주",
    "부산",
    "울산",
    "세종",
    "충청",
    "경상",
    "전라",
    "강원",
    "제주",
  ];

  //사진 변경
  const fileInputHandler = () => {
    fileRef.current?.click();
  };

  const uploadImage = (e: React.ChangeEvent<HTMLInputElement>) => {
    const imgFile = e.target.files;
    const targetFile = (e.target.files as FileList)[0];
    if (imgFile && imgFile[0]) {
      const url = URL.createObjectURL(imgFile[0]);

      setImgSrcList({
        file: imgFile[0],
        thumbnail: url,
        type: imgFile[0].type.slice(0, 5),
        name: imgFile[0].name,
      });
      setImgUp(targetFile);
    }
  };

  const showImg = useMemo(() => {
    if (!imgSrcList && imgSrcList == null) {
      return (
        <svg
          xmlns="http://www.w3.org/2000/svg"
          viewBox="0 0 24 24"
          fill="currentColor"
          className="w-6 h-6 "
          onClick={fileInputHandler}
        >
          <path d="M12 9a3.75 3.75 0 100 7.5A3.75 3.75 0 0012 9z" />
          <path
            fillRule="evenodd"
            d="M9.344 3.071a49.52 49.52 0 015.312 0c.967.052 1.83.585 2.332 1.39l.821 1.317c.24.383.645.643 1.11.71.386.054.77.113 1.152.177 1.432.239 2.429 1.493 2.429 2.909V18a3 3 0 01-3 3h-15a3 3 0 01-3-3V9.574c0-1.416.997-2.67 2.429-2.909.382-.064.766-.123 1.151-.178a1.56 1.56 0 001.11-.71l.822-1.315a2.942 2.942 0 012.332-1.39zM6.75 12.75a5.25 5.25 0 1110.5 0 5.25 5.25 0 01-10.5 0zm12-1.5a.75.75 0 100-1.5.75.75 0 000 1.5z"
            clipRule="evenodd"
          />
        </svg>
      );
    }
    return (
      <img
        src={imgSrcList.thumbnail}
        alt={imgSrcList.type}
        onClick={fileInputHandler}
        className="h-40 object-fill "
      />
    );
  }, [imgSrcList]);

  useEffect(() => {
    categoryHandler();
  }, []);

  return (
    <div className="flex flex-col items-center overflow-y-scroll">
      <div className="w-10/12">
        <HeaderNav />
        <div className="flex mt-32 mb-20">
          <div className="w-1/5 bg-[#E7E7E7] mr-10 h-auto rounded">
            <div className="text-xl mb-12 pt-5 pl-5">공연 관리</div>
            <div className="text-right">
              <p className="mr-4 text-base">신청한 공연 관리</p>
            </div>
          </div>
          <div className="w-4/5 pt-10 pl-10 h-auto border-solid border-2 border-gray-400 rounded flex flex-col">
            <div className="text-xl w-full mb-10 ml-32 font-bold">
              공연 등록
            </div>
            <div className="flex items-end mb-16">
              <p className="w-40 h-48 bg-[#D9D9D9] flex items-center justify-center ml-32 mr-10">
                {showImg}
              </p>
              <input
                type="file"
                accept="imgae"
                ref={fileRef}
                onChange={uploadImage}
                className="file:mr-4  file:py-2 file:px-4 file:rounded file:border-0 file:text-xs file:bg-[#FFE277] file:text-[#0d0d0d] w-3/5 h-8 text-sm"
              ></input>
            </div>
            <div className="flex flex-col my-2 ml-32 text-base">
              <label className="my-2">공연 제목</label>
              <input
                type="text"
                className="border-b-2 border-b-[#0D0D0D] w-3/6 h-12"
                {...title}
              ></input>
            </div>
            <div className="flex">
              <div className="flex flex-col my-2 ml-32 text-base">
                <label className="my-2">공연 카테고리</label>
                <select className="w-40 mt-5" onChange={categorySelectHandler}>
                  {parcategory.map((big, index) => (
                    <option value={big.code} key={index}>
                      {big.name}
                    </option>
                  ))}
                </select>
              </div>
              <div className="flex flex-col my-2 ml-32 text-base">
                <select className="w-52 mt-16">
                  {smcategory.map((small, index) => (
                    <option value={small.code} key={index}>
                      {small.name}
                    </option>
                  ))}
                </select>
              </div>
            </div>
            <div className="flex flex-col my-2 ml-32 text-base">
              <label className="my-2">공연 장소</label>
              <input
                type="text"
                className="border-b-2 border-b-[#0D0D0D] w-3/6 h-12"
              ></input>
            </div>
            <div className="flex flex-col my-2 ml-32 text-base w-40">
              <label className="my-2">공연 기간</label>
              <div className="flex">
                <DatePicker
                  locale={ko}
                  dateFormat="yyyy-MM-dd"
                  closeOnScroll={true}
                  placeholderText="시작 날짜"
                  selected={startDate}
                  className="border-b-2 border-b-[#0D0D0D] h-12 w-auto text-center"
                  onChange={(date) => setStartDate(date!)}
                />
                <p className="px-10 ml-1 mt-3 font-bold">~</p>
                <DatePicker
                  locale={ko}
                  dateFormat="yyyy-MM-dd"
                  closeOnScroll={true}
                  placeholderText="시작 날짜"
                  selected={endDate}
                  className="border-b-2 border-b-[#0D0D0D] h-12 w-auto text-center"
                  onChange={(date) => setEndDate(date!)}
                />
              </div>
            </div>
            <div className="flex flex-col my-2 ml-32 text-base">
              <label className="my-2">연령 제한</label>
              <input
                type="number"
                className="border-b-2 border-b-[#0D0D0D] w-2/6 h-12"
              ></input>
            </div>
            <div className="flex flex-col my-2 ml-32 text-base">
              <label className="my-2">공연 지역</label>
              <select className="w-40 mt-5">
                {location.map((lo, index) => (
                  <option value={lo} key={index}>
                    {lo}
                  </option>
                ))}
              </select>
            </div>
            <div className="my-20 flex justify-center">
              <button className="w-40 h-10 bg-[#FFE277] text-base rounded font-bold">
                등록
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default PerformForm;
