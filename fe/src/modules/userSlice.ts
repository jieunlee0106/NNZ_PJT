import { createSlice, PayloadAction } from "@reduxjs/toolkit";

export interface User {
  token: string;
}

const initialState: User = {
  token: "",
};

export const userSlice = createSlice({
  name: "users",
  initialState,
  reducers: {
    setUser: (state, action: PayloadAction<User>) => {
      state.token = action.payload.token;
    },
  },
});

export const { setUser } = userSlice.actions;
export default userSlice.reducer;
