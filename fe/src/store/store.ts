import { configureStore } from "@reduxjs/toolkit";
import reducer from "../services/rootReducer";

const store = configureStore({
  reducer,
});

export type AppDispatch = typeof store.dispatch;
export default store;
