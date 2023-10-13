import pino from "pino";

let logger = null;

function initLogger() {
    logger = pino()
}

export function getLogger(force = false) {
    if (!logger) {
        initLogger()
    }

    if (force) {
        initLogger()
    }

    return logger
}

export function getChildLogger(properties) {
    const log = getLogger()

    const child = log.child(properties);

    child.buildMessage = function (message, props) {
        return {
            message,
            ...props
        }
    }

    return child;
}