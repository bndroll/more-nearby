import * as dotenv from "dotenv";

import {getChildLogger} from "./src/util/logger.js";
import {initConnection} from "./src/db/index.js";
import {initCrons} from "./src/crons/index.js";
import {initAgenda} from "./src/tasks/index.js";
import {setupInitialData} from "./src/scripts/index.js";

const logger = getChildLogger({ file: "index.js" })

async function init() {
    dotenv.config();

    await initConnection()
    await initAgenda()

    initCrons()

    // await setupInitialData()

    return true;
}


init().then(async () => {
    logger.info("App has been started")
})