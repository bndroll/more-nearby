import mongoose from "mongoose";

const tagSchema = new mongoose.Schema({
    tagId: String,
    title: String,
    type: String,
    prefix: String,
    time: Number,
});

export const Tag = mongoose.model(
    "Tag",
    tagSchema
)