import axios from "axios";

export const BASE_URL = `${import.meta.env.VITE_API_URL}/api`;

const client = axios.create({
  baseURL: BASE_URL,
});

export default client;
