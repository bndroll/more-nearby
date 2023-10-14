/**
 *  move all free users -> fetch all users and make it acting
 */
import {getRandomNumberInInterval} from "../util/random.utils.js";
import {getChildLogger} from "../util/logger.js";
import {API} from "../api/index.js";
import {CashMachine} from "../db/cashMachine.schema.js";
import {Queue} from "../db/queue.schema.js";
import {getAgendaInstance} from "../tasks/index.js";
import {moveAllFreeUsersJob} from "../tasks/moveAllFreeUsers.js";
import {makeUserFree} from "../tasks/makeUserFree.js";

const logger = getChildLogger({ filename: "core/index.js"})

async function makeRandomCacheMachineInteraction(user) {
    const countOfCashMachines = await CashMachine.countDocuments();
    const amountForSkip = getRandomNumberInInterval(0, countOfCashMachines-1);
    const randomCashMachine = await CashMachine.findOne().skip(amountForSkip);

    const amountForOperation = getRandomNumberInInterval(10, randomCashMachine.amountOfMoney / 10)
    const operationType = getRandomNumberInInterval(1, 10) >= 5
        ?  API.cashMachineApi.meta.cashMachineHistoryOperationType.Fill
        :  API.cashMachineApi.meta.cashMachineHistoryOperationType.Take;

    logger.info(logger.buildMessage("User is going to cash machine", {
        userId: user.userId,
        cashMachine: randomCashMachine.cashMachineId,
        amountForOperation,
        operationType
    }));

    await API.cashMachineApi.actWithCashMachine(
        user.userId,
        randomCashMachine.cashMachineId,
        amountForOperation,
        operationType,
        API.cashMachineApi.meta.cashMachineHistoryOperationStatus.Complete
    )

    randomCashMachine.amountOfMoney = randomCashMachine.amountOfMoney - amountForOperation;
    randomCashMachine.save();
}

async function makeRandomTicket(user) {
    logger.info(logger.buildMessage("Ticket action", {
        userId: user.userId
    }))

    const countOfQueues = await Queue.countDocuments();
    const amountForSkip = getRandomNumberInInterval(0, countOfQueues-1);
    const randomQueue = await Queue.findOne().skip(amountForSkip);

    const status = getRandomNumberInInterval(1, 100) > 50
        ? API.ticketApi.meta.ticketStatus.Open
        : API.ticketApi.meta.ticketStatus.Pending;

    try {
        const { data } = await API.ticketApi.createTicket(
            "Я хочу получить банковскую услугу",
            status,
            user.userId,
            randomQueue.tagId,
            new Date(),
            randomQueue.queueId
        )

        return {
            id: data.id,
            predictionTime: data.predictionTime
        };
    } catch (e) {
        logger.error(e);
        await API.ticketApi.closeAllUserTickets(user.userId)
        throw e
    }
}

async function makeRandomUserAction(user) {
    const agenda = getAgendaInstance();
    let time = getRandomNumberInInterval(30, 55);
    let agendaProps = {
        userId: user.userId
    }

    // Выбираем пользователь пойдет в очередь или же просто снять деньги
    const isTicketAction = getRandomNumberInInterval(1, 100) > 50

    if (isTicketAction) {
        let ticketId = null,
            time = 0;

        try {
            const {
               id, predictionTime
            } = await makeRandomTicket(user)

            ticketId = id;
            time = predictionTime
        } catch (e) {
            return
        }

        time = getRandomNumberInInterval(
            Math.floor(time/2),
            time * 2
        )

        agendaProps = {
            ...agendaProps,
            ticketId: ticketId,
            ticketTime: time
        }

        const additionalTimeEntropy = getRandomNumberInInterval(1, 100);
        if (additionalTimeEntropy <= 33) {
            await API.ticketApi.updateAdditionalType(
                ticketId,
                API.ticketApi.meta.ticketAdditionalType.Fast
            )
        } else if (additionalTimeEntropy >= 67) {
            await API.ticketApi.updateAdditionalType(
                ticketId,
                API.ticketApi.meta.ticketAdditionalType.Hard
            )
        }
    } else {
        await makeRandomCacheMachineInteraction(user)
    }

    user.isFree = false;
    await user.save();

    logger.info(logger.buildMessage(
        `in ${time} seconds`,
        agendaProps
    ))
    agenda.schedule(
        `in ${time} minutes`,
        makeUserFree.jobName,
        agendaProps
    );

}

export {
    makeRandomUserAction
}