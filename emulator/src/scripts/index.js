/**
 * Пользователи
 * Банкоматы
 * Отделения (Очереди + Услуги)
 * Сотрудники
 */
import {getRandomNumberInInterval, shuffle} from "../util/random.utils.js";
import {getChildLogger} from "../util/logger.js";
import {API} from "../api/index.js";
import {User} from "../db/user.schema.js";
import {CashMachine} from "../db/cashMachine.schema.js";
import {Department} from "../db/department.schema.js";
import {tagsList} from "./tags.js";
import {Tag} from "../db/tag.schema.js";
import {Queue} from "../db/queue.schema.js";

const logger = getChildLogger({ filename: "initialScript"})

const PICTURE_URL = "https://static.wikia.nocookie.net/gvs/images/d/d5/%D0%93%D0%BB%D0%B0%D0%B4%D0%92%D0%B0%D0%BB%D0%B0%D0%BA%D0%B0%D1%81.jpg/revision/latest?cb=20220512122336&path-prefix=ru"

const firstNames = [
    "Артем",
    "Максим",
    "Георгий",
    "Данил",
    "Кирилл",
    "Александр",
    "Филипп",
    "Владислав",
    "Егор",
    "Коржик"
]

const secondNames = [
    "Баненков",
    "Акутин",
    "Кузнецов",
    "Иванов",
    "Ларионов",
    "Рабинович",
    "Достоевский",
    "Онегин",
    "Есенин",
    "Набоков"
]

const middleNames = [
    "Иванович",
    "Сергеевич",
    "Петрович",
    "Николаевич",
    "Георгиевич",
    "Константинович",
    "Максимович"
]

const posts = [
    "Младший Менеджер",
    "Менеджер",
    "Старший Менеджер",
    "Ведущий Менеджер",
    "Директор"
]

async function setupUsers(amount) {
    for (let i = 0; i < amount; i++) {
        const userName =
            shuffle(secondNames)[0] + " "
            + shuffle(firstNames)[0] + " "
            + shuffle(middleNames)[0];

        const { data } = await API.userApi.createUser(
            userName,
            `${getRandomNumberInInterval(88000000000, 89000000000)}`,
            "password"
        )

        const user = new User({
            userId: data.id,
            isFree: true
        })
        await user.save();
    }
}

async function setupCacheMachines() {
    const { data } = await API.cashMachineApi.createCashMachine(
        "51.537416089456194",
        "46.02541194754179",
        "улица Московская, 101, г. Саратов, Саратовская область, 410012",
        API.cashMachineApi.meta.cashMachineTypes.Own
    )

    await (new CashMachine({amountOfMoney: 0, cashMachineId: data.id}).save())

    const { data: data1 } = await API.cashMachineApi.createCashMachine(
        "51.54248757016543",
        "46.015026435221436",
        "Улица Зарубина, В.С., д. 1 167, г. Саратов, Саратовская область, 410005",
        API.cashMachineApi.meta.cashMachineTypes.Own
    )

    await (new CashMachine({amountOfMoney: 0, cashMachineId: data1.id}).save())

    const { data: data2 } = await API.cashMachineApi.createCashMachine(
        "51.54803885895958",
        "46.01579891134444",
        "улица Танкистов, 3, г. Саратов, Саратовская область, 410005",
        API.cashMachineApi.meta.cashMachineTypes.Own
    )

    await (new CashMachine({amountOfMoney: 0, cashMachineId: data2.id}).save())

    const { data: data3 } = await API.cashMachineApi.createCashMachine(
        "51.5431815183033",
        "45.99897609799908",
        "улица Аткарская, 57, г. Саратов, Саратовская область, 410012",
        API.cashMachineApi.meta.cashMachineTypes.Own
    )

    await (new CashMachine({amountOfMoney: 0, cashMachineId: data3.id}).save())

    const { data: data4 } = await API.cashMachineApi.createCashMachine(
        "51.54275447454777",
        "45.99931942072041",
        "Привокзальная площадь, 1, Саратов, Саратовская область, 410012",
        API.cashMachineApi.meta.cashMachineTypes.Partner
    )

    await (new CashMachine({amountOfMoney: 0, cashMachineId: data4.id}).save())

    const { data: data5 } = await API.cashMachineApi.createCashMachine(
        "51.53111598960522",
        "46.01279483753277",
        "ул. им Рахова, 89, В.Г, г. Саратов, Саратовская область, 410056",
        API.cashMachineApi.meta.cashMachineTypes.Own
    )

    await (new CashMachine({amountOfMoney: 0, cashMachineId: data5.id}).save())

    const { data: data6 } = await API.cashMachineApi.createCashMachine(
        "51.521931231334186",
        "46.00198017181075",
        "2-я Садовая улица, уч23А, Саратов, Саратовская область, 410004",
        API.cashMachineApi.meta.cashMachineTypes.Partner
    )

    await (new CashMachine({amountOfMoney: 0, cashMachineId: data6.id}).save())

    const { data: data7 } = await API.cashMachineApi.createCashMachine(
        "51.525562636287276",
        "45.97992168696505",
        "Политехническая улица, 65/1, Саратов, Саратовская область, 410008",
        API.cashMachineApi.meta.cashMachineTypes.Own
    )

    await (new CashMachine({amountOfMoney: 0, cashMachineId: data7.id}).save())
}

export async function setupDepartments() {
    const { data } = await API.departmentApi.createDepartment(
        "Отделение 1",
        "51.53319832246817",
        "46.01785884767244",
        "Улица имени Василия Люкшина, 5, г. Саратов, Саратовская область, 410012"
    )

    await (new Department({departmentId: data.id}).save())

    const { data: data2 } = await API.departmentApi.createDepartment(
        "Отделение 2",
        "51.530368462266786",
        "46.01914630787744",
        "улица Советская, 51, г. Саратов, Саратовская область, 410056"
    )

    await (new Department({departmentId: data2.id}).save())

    const { data: data3 } = await API.departmentApi.createDepartment(
        "Отделение 3",
        "51.56292791329274",
        "46.028845174755126",
        "улица Высокая, 12А, г. Саратов, Саратовская область, 410019"
    )

    await (new Department({departmentId: data3.id}).save())
}

async function setupTags() {

    for (let tag of tagsList) {
        const { data } = await API.tagsApi.createTag(
            tag.title,
            tag.prefix,
            tag.time,
            tag.type
        )
        await (new Tag({...tag, tagId: data.id })).save()
    }
}

async function setupQueues(amount) {
    const departments = await Department.find()
    const tags = await Tag.find()

    for (let i = 0; i < amount; i++) {
        const { data } = await API.departmentApi.createDepartmentQueue(
            "none",
            shuffle(tags)[0].tagId,
            shuffle(departments)[0].departmentId
        )

        await (new Queue({
            queueId: data.id,
            tagId: data.tagId,
            departmentId: data.departmentId
        })).save()
    }
}

export async function setupInitialData() {
    await setupUsers(25)
    await setupCacheMachines()
    await setupDepartments()
    await setupTags()
    await setupQueues(15)
}