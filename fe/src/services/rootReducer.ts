import { combineReducers } from "@reduxjs/toolkit";
import userSlice from "../modules/userSlice";

const reducer = combineReducers({
  userSlice,
});

export type ReducerType = ReturnType<typeof reducer>;
export default reducer;
