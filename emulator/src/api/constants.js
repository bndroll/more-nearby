export const ADMIN_TOKEN_HEADER_NAME = 'x-admin-key'

let url = null;
export function getMainUrl() {
    if (!url) {
        url = process.env.MAIN_BACKEND_URL
    }

    return url;
}