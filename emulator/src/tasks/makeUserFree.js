import {getChildLogger} from "../util/logger.js";
import {User} from "../db/user.schema.js";

const logger = getChildLogger({ file: "makeUserFree"})

export const makeUserFree = {
    jobName: "Make User Free",
    action: async job => {
        logger.info("Starting job")
        const { userId } = job.attrs.data;
        const user = await User.find({ userId: userId })
        user.isFree = true;
        await user.save()

        logger.info(logger.buildMessage("User is free", { userId }))
    },
    properties: { priority: 'high', concurrency: 10 }
}