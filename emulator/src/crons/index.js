import * as cron from 'node-cron'

import {getChildLogger} from "../util/logger.js";
import {API} from "../api/index.js";
import {CashMachine} from "../db/cashMachine.schema.js";

const logger = getChildLogger({ file: "crons"})

export function initCrons() {
    initUpdateBalanceCron()
}

function initUpdateBalanceCron() {
    cron.schedule( "*/5 * * * *", async () => {
        const machines = await CashMachine.find();
        for (const machine of machines) {
            await API.cashMachineApi.updateBalance(
                machine._doc.cashMachineId,
                100000
            )

            await CashMachine.updateOne({
                cashMachineId: machine._doc.cashMachineId
            }, {
                amountOfMoney: machine._doc.amountOfMoney + 100000
            })
        }
    })
}