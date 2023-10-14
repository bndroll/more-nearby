import axios from "axios";
import {ADMIN_TOKEN_HEADER_NAME, getMainUrl} from "./constants.js";

const cashMachineTypes = {
    Own: "Own",
    Partner: "Partner"
}

const cashMachineHistoryOperationType = {
    Fill: "Fill",
    Take: "Take"
}

const cashMachineHistoryOperationStatus = {
    Complete: "Complete",
    Error: "Error"
}

const createCashMachine = async (
    lat,
    lon,
    address,
    type,
    info = ""
) =>
    axios.post(`${getMainUrl()}/cash-machine`, {
        lat, lon, address, type, info
    }, {
        headers: {
            [ADMIN_TOKEN_HEADER_NAME]: process.env.ADMIN_TOKEN
        }
    })

const actWithCashMachine = async (
    userId,
    cashMachineId,
    sum,
    operation,
    status
) =>
    axios.patch(`${getMainUrl()}/cash-machine/${cashMachineId}`, {
        userId, cashMachineId, sum, operation, status
    })

const updateBalance = async (
    cashMachineId,
    balance
) =>
    axios.patch(`${getMainUrl()}/cash-machine/${cashMachineId}/force`, {
        cashMachineId, balance
    })

export const cashMachineApi = {
    createCashMachine,
    actWithCashMachine,
    updateBalance,

    meta: {
        cashMachineTypes,
        cashMachineHistoryOperationType,
        cashMachineHistoryOperationStatus
    }
}