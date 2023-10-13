import axios from "axios";
import {getMainUrl} from "./constants.js";

const ticketStatus = {
    Open: "Open", // сразу в отделении
    Pending: "Pending", // Из дома
}

const createTicket = async (
    request, // Текст предзаполненного заявления
    status,
    userId,
    tagId,
    visitDate,
    departmentQueueId
) =>
    axios.post(`${getMainUrl()}/ticket`, {
        request,
        status,
        userId,
        tagId,
        visitDate,
        departmentQueueId
    })

export const ticketApi = {
    createTicket,

    meta: {
        ticketStatus
    }
}