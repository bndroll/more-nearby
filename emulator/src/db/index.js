import mongoose from "mongoose";

export async function initConnection() {
    await mongoose.connect(getMongoConnectionString());
}

export function getMongoConnectionString() {
    return `mongodb://${process.env.MONGO_HOST}:${process.env.MONGO_PORT}/${process.env.MONGO_DB}`;
}
