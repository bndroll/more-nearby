import axios from "axios";
import {ADMIN_TOKEN_HEADER_NAME, getMainUrl} from "./constants.js";

const createDepartment = async (
    title,
    lat,
    lon,
    address,
    info = ""
) =>
    axios.post(`${getMainUrl()}/department`, {
        title, lat, lon, address, info
    },{
        headers: {
            [ADMIN_TOKEN_HEADER_NAME]: process.env.ADMIN_TOKEN
        }
    });

const createDepartmentQueue = async (
    title,
    tagId,
    departmentId
) =>
    axios.post(`${getMainUrl()}/department-queue`, {
        title, tagId, departmentId
    },{
        headers: {
            [ADMIN_TOKEN_HEADER_NAME]: process.env.ADMIN_TOKEN
        }
    })

export const departmentApi = {
    createDepartment,
    createDepartmentQueue
};