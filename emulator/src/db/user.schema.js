import mongoose from "mongoose";

const userSchema = new mongoose.Schema({
    userId: String,
    isFree: Boolean
});

export const User = mongoose.model(
    "User",
    userSchema
)