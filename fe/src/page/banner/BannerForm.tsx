import { useState } from "react";
import HeaderNav from "../../components/HeaderNav";
import axiosApi from "../../services/axiosApi";

function BannerForm() {
  const [showImages, setShowImages]: any = useState([]);
  const [performId, setPerformId] = useState<any>([]);
  const [insertId, setInsertId] = useState(0);

  interface dataType {
    showIds: [];
  }
  //공연 번호 넣기
  const changePerform = (e: any) => {
    setInsertId(e.target.value);
  };
  const makeIdListHandler = () => {
    performId.push(Number(insertId));
    setInsertId(0);
  };
  const idDeleteHandler = (id: number) => {
    setPerformId(performId.filter((_: any, index: number) => index !== id));
  };

  //사진 업로드
  const handleAddImages = (event: any) => {
    const imageLists = event.target.files;
    let imageUrlLists = [...showImages];

    for (let i = 0; i < imageLists.length; i++) {
      const currentImageUrl = URL.createObjectURL(imageLists[i]);
      imageUrlLists.push(currentImageUrl);
    }

    if (imageUrlLists.length > 3) {
      imageUrlLists = imageUrlLists.slice(0, 3);
    }

    setShowImages(imageUrlLists);
  };
  const handleDeleteImage = (id: number) => {
    setShowImages(showImages.filter((_: any, index: number) => index !== id));
  };

  const formdata = new FormData();
  const data: dataType = {
    showIds: performId,
  };

  formdata.append("data", JSON.stringify(data));

  formdata.append("banners", showImages);

  // showImages.forEach((image: any) => formdata.append("banners", image as File));

  //데이터 보내기
  const sendDataHandler = async (e: any) => {
    try {
      const res = await axiosApi.post("admin-service/admin/banners", formdata, {
        headers: { "Content-Type": "multipart/form-data" },
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
          <div className="w-1/5 bg-[#E7E7E7] mr-10 h-100 mb-20 rounded">
            <div className="text-xl mb-12 pt-5 pl-5">배너 등록</div>
          </div>
          <div className="w-4/5 pl-5 h-100 mb-20">
            <div className="text-xl text-left mb-2">배너 등록</div>
            <div className="border-solid border-2 h-52 border-gray-400 rounded flex flex-col">
              <div className="flex pt-5 pl-5 mt-5 w-5/6 justify-around">
                <p className="w-1/5 text-sm">공연 번호</p>
                <input
                  type="integer"
                  onChange={changePerform}
                  className="border-solid border-2 border-gray-400 rounded w-3/5 h-8"
                ></input>
                <button
                  className="border-none rounded bg-[#FFE277] px-4 text-sm"
                  onClick={makeIdListHandler}
                >
                  등록
                </button>
              </div>
              <div className="flex justify-center">
                {performId.map((num: any, id: any) => (
                  <div
                    key={id}
                    className="mx-2 flex justify-center items-center"
                  >
                    <p>{num}</p>
                    <button
                      onClick={() => idDeleteHandler(id)}
                      className="border-solid border-2 border-gray-400 rounded w-12 text-sm mt-2"
                    >
                      삭제
                    </button>
                  </div>
                ))}
              </div>
              <div className="flex pt-1 pl-5 mt-5 w-5/6 justify-around">
                <p className="w-1/5 text-sm">이미지 선택</p>
                <input
                  type="file"
                  id="input-file"
                  onChange={handleAddImages}
                  className="file:mr-4  file:py-2 file:px-4 file:rounded file:border-0 file:text-xs file:bg-[#FFE277] file:text-[#0d0d0d] w-3/5 h-8 text-sm"
                ></input>
              </div>
              <div className="pl-14">
                <p className="text-xs text-gray-400 text-center">
                  (배너 이미지 배율은 실제 앱 배너 이미지 배율인 가로:세로
                  180:115를 권장합니다)
                </p>
              </div>
            </div>
            <div className="mt-6 text-xl text-left mb-2">선택된 배너</div>
            <div className="pl-5 h-56 mb-4 border-solid border-2 border-gray-400 rounded">
              <div className="flex h-52 items-center justify-around">
                {showImages.map((pic: any, id: any) => (
                  <div
                    key={id}
                    className="mx-2 flex flex-col justify-center items-center "
                  >
                    <img
                      src={pic}
                      alt={`${pic}-${id}`}
                      className="w-40 h-32"
                    ></img>
                    <button
                      onClick={() => handleDeleteImage(id)}
                      className="border-solid border-2 border-gray-400 rounded w-12 text-sm mt-2"
                    >
                      삭제
                    </button>
                  </div>
                ))}
              </div>
            </div>
            <div className="w-full flex justify-center items-center mt-8">
              <button
                className="w-36 h-8 bg-[#FFE277] text-sm rounded font-bold"
                onClick={sendDataHandler}
              >
                등록
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default BannerForm;
