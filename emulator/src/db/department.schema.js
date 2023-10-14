import mongoose from "mongoose";

const departmentSchema = new mongoose.Schema({
    departmentId: String,
});

export const Department = mongoose.model(
    "Department",
    departmentSchema
)