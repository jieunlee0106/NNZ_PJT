import axios from "axios";

const axiosLogin = axios.create({
  baseURL: "https://k8b207.p.ssafy.io/api",
});

export default axiosLogin;
