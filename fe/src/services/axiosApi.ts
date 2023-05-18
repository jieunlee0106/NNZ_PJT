import axios from "axios";

const token = sessionStorage.getItem("accsesstoken");

const axiosApi = axios.create({
  baseURL: "https://k8b207.p.ssafy.io/api",
  headers: {
    Authorization: `Bearer ${token}`,
  },
});

export default axiosApi;
