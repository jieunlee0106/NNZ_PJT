import axios from "axios";

const axiosApi = axios.create({
  baseURL: "https://k8b207.p.ssafy.io/api",
});

export default axiosApi;
