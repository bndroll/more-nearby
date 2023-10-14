import {getChildLogger} from "../util/logger.js";
import {User} from "../db/user.schema.js";
import {API} from "../api/index.js";

const logger = getChildLogger({ file: "makeUserFree"})

export const makeUserFree = {
    jobName: "Make User Free",
    action: async job => {
        const { userId, ticketId, ticketTime } = job.attrs.data;
        logger.info({
            userId,
            ticketId,
            ticketTime
        },"Starting job")

        if (ticketId) {
            try {
                await API.ticketApi.closeTicket(
                    ticketId,
                    ticketTime
                )
            } catch (e) {
                logger.error(e)
            }
        }

        const user = await User.findOne({ userId: userId })
        user.isFree = true;
        await user.save()

        logger.info(logger.buildMessage("User is free",
            {
                ticketTime,
                ticketId,
                userId
            }
        ))
    },
    properties: { priority: 'high', concurrency: 10 }
}