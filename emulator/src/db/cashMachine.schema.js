import mongoose from "mongoose";

const cashMachineSchema = new mongoose.Schema({
    cashMachineId: String,
    amountOfMoney: Number
});

export const CashMachine = mongoose.model(
    "CashMachine",
    cashMachineSchema
)