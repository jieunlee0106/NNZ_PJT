import { useNavigate } from "react-router-dom";
import logo from "../../assets/nnzlogo.png";
import axiosApi from "../../services/axiosApi";
import useInput from "../../services/useInput";
import axiosLogin from "../../services/axiosLogin";

function Login() {
  const navigate = useNavigate();
  const userId = useInput("");
  const userPassword = useInput("");

  const loginHandler = async (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    try {
      const res = await axiosLogin.post("user-service/users/login", {
        email: userId.value,
        pwd: userPassword.value,
      });
      console.log(res);
      sessionStorage.setItem("accsesstoken", res.data.accessToken);
      navigate("/perform");
    } catch (err) {
      console.log(err);
    }
  };

  return (
    <div className="flex flex-col items-center pt-20">
      <img src={logo} alt="로고" className="w-80 mb-3" />
      <div className="text-[#0d0d0d] text-xl mb-36">
        나너주의 관리자 페이지입니다
      </div>
      <form className="flex flex-col" onSubmit={loginHandler}>
        <input
          type="text"
          {...userId}
          placeholder="관리자 아이디"
          className="border-b-2 border-b-gray-300 w-80 mb-8 text-base"
        ></input>
        <input
          type="password"
          {...userPassword}
          placeholder="비밀번호 입력"
          className="w-80 text-base border-b-2 border-b-gray-300 mb-10"
        ></input>
        <button className="w-80 h-12 rounded-sm bg-[#FFE277]">로그인</button>
      </form>
    </div>
  );
}
export default Login;
