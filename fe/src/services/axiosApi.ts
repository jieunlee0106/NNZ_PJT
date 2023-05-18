import axios from "axios";
import { useSelector } from "react-redux";

const token = sessionStorage.getItem("accsesstoken");

const axiosApi = axios.create({
  baseURL: "https://k8b207.p.ssafy.io/api",
});

export default axiosApi;
