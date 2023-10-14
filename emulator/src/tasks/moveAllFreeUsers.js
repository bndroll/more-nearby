import {getChildLogger} from "../util/logger.js";
import {User} from "../db/user.schema.js";
import {makeRandomUserAction} from "../core/index.js";

const logger = getChildLogger({ file: "moveAllFreeUsersJob"})

export const moveAllFreeUsersJob = {
    jobName: "Move All Free",
    action: async job => {
        logger.info("Starting job")
        const freeUsers = await User.find({ isFree: true })
        logger.info(`Free users count: ${freeUsers.length}`)
        freeUsers.forEach(makeRandomUserAction)
    },
    properties: { priority: 'high', concurrency: 10 }
}