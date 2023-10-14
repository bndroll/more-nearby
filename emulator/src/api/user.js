import axios from "axios";
import {ADMIN_TOKEN_HEADER_NAME, getMainUrl} from "./constants.js"

const createUser = async (
    name,
    phone,
    password
) =>
    axios.post(`${getMainUrl()}/auth/signup`, {
        name,
        phone,
        password
    });

const createEmployee = async (
    name,
    picture,
    post,
    departmentId,
    departmentQueueId
) =>
    axios.post(`${getMainUrl()}/employee`, {
        name, picture, post, departmentId, departmentQueueId
    }, {
        headers: {
            [ADMIN_TOKEN_HEADER_NAME]: process.env.ADMIN_TOKEN
        }
    })

export const userApi = {
    createUser,
    createEmployee
}