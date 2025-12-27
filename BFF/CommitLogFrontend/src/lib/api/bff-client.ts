import axios from "axios";

export const bffClient = axios.create({
  baseURL: "/bff",
  withCredentials: true,
  headers: {
    "X-CSRF": 1,
  },
});
