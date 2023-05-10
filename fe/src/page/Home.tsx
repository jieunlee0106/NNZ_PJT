import { Route, Routes } from "react-router-dom";
import PerformHome from "./perform/PerformHome";
import Login from "./login/Login";
import Main from "./login/Main";
import ReportHome from "./report/ReportHome";
import BannerForm from "./banner/BannerForm";
import PerformDetail from "./perform/PerformDetail";
import PerformForm from "./perform/PerformForm";
import ReportDetail from "./report/ReportDetail";

const Home = () => {
  return (
    <div>
      <Routes>
        <Route path="/Login" element={<Login />}></Route>
        <Route path="/home" element={<Main />}></Route>
        <Route path="/perform/*" element={<PerformHome />}></Route>
        <Route path="/perform/:id" element={<PerformDetail />}></Route>
        <Route path="/perform/:id/register" element={<PerformForm />}></Route>
        <Route path="/report/*" element={<ReportHome />}></Route>
        <Route path="/report/:id" element={<ReportDetail />}></Route>
        <Route path="/banner/*" element={<BannerForm />}></Route>
      </Routes>
    </div>
  );
};

export default Home;
