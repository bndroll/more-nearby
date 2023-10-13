import mongoose from "mongoose";

const queueSchema = new mongoose.Schema({
    queueId: String,
    tagId: String,
    departmentId: String
});

export const Queue = mongoose.model(
    "Queue",
    queueSchema
)