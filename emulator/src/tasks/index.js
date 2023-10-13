import {Agenda} from "@hokify/agenda";
import {getMongoConnectionString} from "../db/index.js";
import {moveAllFreeUsersJob} from "./moveAllFreeUsers.js";
import {makeUserFree} from "./makeUserFree.js";

let agenda = null

function defineAllJob() {
    getAgendaInstance().define(
        moveAllFreeUsersJob.jobName,
        moveAllFreeUsersJob.action,
        moveAllFreeUsersJob.properties,
    )

    getAgendaInstance().define(
        makeUserFree.jobName,
        makeUserFree.action,
        makeUserFree.properties,
    )
}

export async function initAgenda() {
    defineAllJob()
    await getAgendaInstance().start()

    await getAgendaInstance().every(
        '1 minute',
        moveAllFreeUsersJob.jobName,
    )
}

export function getAgendaInstance() {
    if (!agenda) {
        agenda = new Agenda({ db: { address: getMongoConnectionString() } });
    }

    return agenda
}