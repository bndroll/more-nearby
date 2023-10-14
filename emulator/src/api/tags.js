import axios from "axios";
import {ADMIN_TOKEN_HEADER_NAME, getMainUrl} from "./constants.js";

const createTag = async (
    title,
    prefix,
    time, // среднее число минут
    type
) =>
    axios.post(`${getMainUrl()}/tag`, {
        title, prefix, time, type
    }, {
        headers: {
            [ADMIN_TOKEN_HEADER_NAME]: process.env.ADMIN_TOKEN
        }
    })

export const tagsApi = {
    createTag
}