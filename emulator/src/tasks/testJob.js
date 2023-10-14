import {getChildLogger} from "../util/logger.js";

const logger = getChildLogger({ file: "testJob"})

export const testJob = {
    jobName: "Test Job",
    action: async job => {
        const { meta } = job.attrs.data;
        logger.info(meta)
    },
    properties: { priority: 'high', concurrency: 10 }
}