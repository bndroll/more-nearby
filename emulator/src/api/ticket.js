import axios from "axios";
import {ADMIN_TOKEN_HEADER_NAME, getMainUrl} from "./constants.js";

const ticketStatus = {
    Open: "Open", // сразу в отделении
    Pending: "Pending", // Из дома
}

const ticketAdditionalType = {
    Normal: "Normal",
    Fast: "Fast",
    Hard: "Hard"
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
    });

const closeTicket = async (
    ticketId,
    resultTime
) =>
    axios.patch(`${getMainUrl()}/ticket/${ticketId}/close`, {
        resultTime
    }, {
        headers: {
            [ADMIN_TOKEN_HEADER_NAME]: process.env.ADMIN_TOKEN
        }
    });


const updateAdditionalType = async (
    ticketId,
    additionalType
) =>
    axios.patch(`${getMainUrl()}/ticket/${ticketId}/additional`, {
        additionalType
    }, {
        headers: {
            [ADMIN_TOKEN_HEADER_NAME]: process.env.ADMIN_TOKEN
        }
    });

const closeAllUserTickets = async (
    userId
) =>
    axios.patch(`${getMainUrl()}/ticket/close/by-user-id/${userId}/`,
        {},
        {
            headers: {
                [ADMIN_TOKEN_HEADER_NAME]: process.env.ADMIN_TOKEN
            }
        });

export const ticketApi = {
    createTicket,
    closeTicket,
    updateAdditionalType,
    closeAllUserTickets,

    meta: {
        ticketStatus,
        ticketAdditionalType
    }
}