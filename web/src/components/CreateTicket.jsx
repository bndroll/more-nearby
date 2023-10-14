import { useCallback, useEffect, useState } from "react";
import { Button, Divider, Input, Sheet, Typography } from "@mui/joy";
import { ArrowBack } from "@mui/icons-material";
import { UIChip } from "./common/UIChip";
import {
  servicesList,
  statusToText,
  getStatus,
  statusToType,
  getStatusFromGraph,
} from "../constants";
import { createTicket, getDepartment, getDepartments } from "../api/api";
import { DepartmentItemSmall } from "./common/DepartmentItemSmall";
import { BarChart, Bar, XAxis } from "recharts";

const chartData = [
  { name: 9, count: 50 },
  { name: 10, count: 54 },
  { name: 11, count: 23 },
  { name: 12, count: 32 },
  { name: 13, count: 68 },
  { name: 14, count: 70 },
  { name: 15, count: 56 },
  { name: 16, count: 32 },
  { name: 17, count: 20 },
  { name: 18, count: 15 },
];

const timings = ["3 минутах", "5 минутах", "10 минутах"];
const transports = [
  "Пешком",
  "На машине",
  "На самокате",
  "На такси",
  "На общественном транспорте",
];

const reminders = [
  "За 30 минут",
  "За час",
  "За 2 часа",
  "За 4 часа",
  "За 6 часов",
  "За 8 часов",
  "Не напоминайте",
];

export const CreateTicket = ({ finish }) => {
  const [step, setStep] = useState(1);
  const [fio, setFio] = useState("");
  const [filters, setFilters] = useState([]);
  const [address, setAdderss] = useState("");
  const [phone, setPhone] = useState("");
  const [departments, setDepartments] = useState([]);
  const [selectedForTicket, setSelectedForTicket] = useState(null);
  const [time, setTime] = useState("");
  const [transport, setTransport] = useState("");
  const [reminder, setReminder] = useState("");
  const [showFinal, setShowFinal] = useState(false);

  const moveBack = useCallback(() => {
    if (step === 1) {
      finish();
      return;
    }

    setStep((prev) => prev - 1);
  }, [step]);

  const nextStep = useCallback(async () => {
    if (step === 3) {
      const res = await create();
      if (res.status === 201) {
        setShowFinal(true);
      }
      return;
    }

    setStep((prev) => prev + 1);
  }, [step]);

  useEffect(async () => {
    if (step === 2) {
      const deps = await getDepartments(filters.map((f) => f.type));
      setDepartments(deps);
      const dep = await getDepartment(deps[0].id);
      setSelectedForTicket(dep);
    }
  }, [step, filters]);

  const selectForTicket = async (item) => {
    const dep = await getDepartment(item.id);
    setSelectedForTicket(dep);
  };

  const create = useCallback(async () => {
    const tag = filters[0];

    const queue = selectedForTicket.queues.find(
      (q) => q.tagTitle === tag.title
    );

    const payload = {
      request: "",
      status: "Pending",
      userId: "6f0d591a-c15f-496d-a5ce-380214e9566e",
      tagId: queue.tagId,
      visitDate: new Date(),
      departmentQueueId: queue.id,
    };
    return createTicket(payload);
  }, [fio, phone, selectedForTicket]);

  return (
    <div
      style={{
        position: "fixed",
        top: 48,
        left: 24,
        bottom: 16,
        display: "flex",
        flexDirection: "column",
        width: "400px",
      }}
    >
      <Sheet
        variant="soft"
        color="neutral"
        sx={{
          borderRadius: 16,
          boxShadow:
            "var(--joy-shadowRing, 0 0 #000),0px 2px 8px -2px rgba(var(--joy-shadowChannel, 21 21 21) / var(--joy-shadowOpacity, 0.08)),0px 20px 24px -4px rgba(var(--joy-shadowChannel, 21 21 21) / var(--joy-shadowOpacity, 0.08))",
          background: "white",
          px: 2,
          py: 2,
          height: "100%",
          display: "flex",
          flexDirection: "column",
        }}
      >
        {!showFinal && (
          <>
            <div>
              <ArrowBack
                onClick={() => moveBack()}
                sx={{ cursor: "pointer" }}
              />
            </div>
            <div style={{ display: "flex", justifyContent: "space-between" }}>
              <Typography level="title-lg">Оформление заявки</Typography>
              <Typography level="title-lg">{step} из 3</Typography>
            </div>
          </>
        )}
        {step === 1 && (
          <div
            style={{
              marginTop: "16px",
              heigth: "100%",
              height: "100%",
              display: "flex",
              flexDirection: "column",
            }}
          >
            <Typography level="title-lg" sx={{ fontWeight: 300, mb: 1 }}>
              Добрый день, Я
            </Typography>
            <Input
              sx={{ mb: 1 }}
              variant="outlined"
              placeholder="Иванов Иван Иванович"
              value={fio}
              onChange={(e) => setFio(e.target.value)}
            />
            <Typography level="title-lg" sx={{ fontWeight: 300, mb: 1 }}>
              планирую совершить визит в ваше банковское отделение и хотел(а) бы
              обсудить вопрос(ы)
            </Typography>
            <div>
              {servicesList.map((item, index) => {
                const checked = !!filters.find((f) => f.type === item.type);
                return (
                  <UIChip
                    key={index}
                    label={item.title}
                    checkedColor="white"
                    uncheckedColor="#0C277D"
                    checked={checked}
                    onChange={(e) => {
                      setFilters((prev) =>
                        !e.target.checked
                          ? prev.filter((n) => n.type !== item.type)
                          : [...prev, item]
                      );
                    }}
                  />
                );
              })}
            </div>
            <Typography level="title-lg" sx={{ fontWeight: 300, mb: 1, mt: 2 }}>
              Подбирая отделение, учтите, что после визита я поеду по адресу
            </Typography>
            <Input
              sx={{ mb: 1 }}
              variant="outlined"
              placeholder="Саратов, Зарубина 128"
              value={address}
              onChange={(e) => setAdderss(e.target.value)}
            />
            <Typography level="title-lg" sx={{ fontWeight: 300, mb: 1 }}>
              И да, если возникнет срочный вопрос, то вы можете связаться по
              телефону
            </Typography>
            <Input
              sx={{ mb: 1 }}
              variant="outlined"
              placeholder="+7 (900) 000 00 00"
              value={phone}
              maxLength={11}
              onChange={(e) => setPhone(e.target.value)}
            />
          </div>
        )}

        {step == 2 && (
          <>
            <div style={{ marginTop: "16px" }}>
              {selectedForTicket && (
                <div
                  style={{
                    border: "1px solid #CDD7E1",
                    borderRadius: "8px",
                    padding: "8px",
                  }}
                >
                  <DepartmentItemSmall item={selectedForTicket} />
                  <div style={{ marginTop: "8px" }}>
                    <UIChip
                      label={
                        statusToText[
                          getStatusFromGraph(selectedForTicket.graph)
                        ]
                      }
                      checked={true}
                      checkedColor="white"
                      type={
                        statusToType[
                          getStatusFromGraph(selectedForTicket.graph)
                        ]
                      }
                    />
                    <UIChip
                      label="Ожидание ~25 мин"
                      checked={true}
                      checkedColor="black"
                      type="neutral"
                    />
                  </div>
                  <div
                    style={{
                      border: "1px solid #CDD7E1",
                      borderRadius: "8px",
                      padding: "8ox",
                      display: "flex",
                      justifyContent: "center",
                      marginBottom: "8px",
                    }}
                  >
                    <BarChart
                      width={350}
                      height={140}
                      data={selectedForTicket.graph}
                    >
                      <XAxis dataKey="num" />
                      <Bar dataKey="value" fill="#9CA9CA" barSize={35} />
                    </BarChart>
                  </div>
                  <div>
                    <Typography level="title-md">
                      Рекомендуем приходить до обеда
                    </Typography>
                    <Typography level="body-xs">
                      Подберите наиболее удобное время с учетом загруженности
                      отделения
                    </Typography>
                  </div>
                  <Button
                    disabled
                    variant="primary"
                    size="lg"
                    sx={{ width: "100%", mt: 1 }}
                  >
                    Выбрано
                  </Button>
                </div>
              )}
            </div>
            <div>
              <Typography
                level="title-lg"
                sx={{ fontWeight: 300, mt: 3, mb: 1 }}
              >
                Другие отделения:
              </Typography>
              <div>
                {departments
                  .filter((dep) => dep.id !== selectedForTicket?.id)
                  .map((item) => (
                    <div
                      key={item.id}
                      style={{
                        border: "1px solid #CDD7E1",
                        borderRadius: "8px",
                        padding: "8px",
                        marginBottom: "8px",
                      }}
                    >
                      <DepartmentItemSmall item={item} />
                      <div style={{ marginTop: "8px" }}>
                        <UIChip
                          label={statusToText[getStatus(item.target)]}
                          checked={true}
                          checkedColor="white"
                          type={statusToType[getStatus(item.target)]}
                        />
                        <UIChip
                          label="Ожидание ~25 мин"
                          checked={true}
                          checkedColor="black"
                          type="neutral"
                        />
                      </div>
                      <Button
                        color="primary"
                        size="md"
                        sx={{ width: "100%", mt: 1, borderRadius: 16 }}
                        onClick={() => selectForTicket(item)}
                      >
                        Выбрать
                      </Button>
                    </div>
                  ))}
              </div>
            </div>
          </>
        )}
        {step == 3 && !showFinal && (
          <>
            <div style={{ marginTop: "16px" }}>
              <Typography level="title-md" sx={{ fontWeight: 300 }}>
                Поставьте меня в очередь, когда я буду в
              </Typography>
              <div
                style={{
                  marginTop: "8px",
                  display: "flex",
                  alignItems: "start",
                }}
              >
                {timings.map((item, index) => {
                  const checked = time === item;
                  return (
                    <UIChip
                      size="sm"
                      key={index}
                      label={item}
                      checkedColor="white"
                      uncheckedColor="#0C277D"
                      checked={checked}
                      onChange={(e) => {
                        setTime(item);
                      }}
                    />
                  );
                })}
                <Typography level="title-md" sx={{ fontWeight: 300 }}>
                  пути
                </Typography>
              </div>
              <div
                style={{
                  marginTop: "8px",
                  display: "flex",
                  alignItems: "start",
                }}
              >
                <Typography
                  level="title-md"
                  sx={{ fontWeight: 300, marginRight: "8px" }}
                >
                  от отделения, взамен я
                </Typography>
                <UIChip
                  size="sm"
                  label="Помогу больным детям"
                  checkedColor="white"
                  uncheckedColor="#0C277D"
                  checked
                  type="success"
                />
              </div>
              <div
                style={{
                  marginTop: "8px",
                  display: "flex",
                  alignItems: "start",
                }}
              >
                <UIChip
                  size="sm"
                  label="Потрачу VTB-coins"
                  checkedColor="white"
                  uncheckedColor="#0C277D"
                  checked={false}
                />
                <Typography
                  level="title-md"
                  sx={{ fontWeight: 300, marginRight: "8px" }}
                >
                  на сумму
                </Typography>
                <Typography
                  level="title-md"
                  sx={{ fontWeight: 400, marginRight: "8px", color: "#269226" }}
                >
                  50 рублей
                </Typography>
              </div>
            </div>
            <Divider sx={{ my: 1 }} />
            <div>
              <Typography level="title-lg" sx={{ mb: 1 }}>
                Я доберусь до отделения
              </Typography>
              {transports.map((item, index) => {
                const checked = transport === item;
                return (
                  <UIChip
                    size="sm"
                    key={index}
                    label={item}
                    checkedColor="white"
                    uncheckedColor="#0C277D"
                    checked={checked}
                    onChange={(e) => {
                      setTransport(item);
                    }}
                  />
                );
              })}
            </div>
            <Divider sx={{ my: 1 }} />
            <div>
              <Typography level="title-lg" sx={{ mb: 1 }}>
                Напомните мне о визите
              </Typography>
              {reminders.map((item, index) => {
                const checked = reminder === item;
                return (
                  <UIChip
                    size="sm"
                    key={index}
                    label={item}
                    checkedColor="white"
                    uncheckedColor="#0C277D"
                    checked={checked}
                    onChange={(e) => {
                      setReminder(item);
                    }}
                  />
                );
              })}
            </div>
          </>
        )}
        {showFinal && (
          <>
            <Typography level="title-lg">
              Заявка была успешно оформлена!
            </Typography>
            <div style={{ marginTop: "16px" }}>
              <DepartmentItemSmall item={selectedForTicket} />
              <Divider sx={{ my: 1 }} />
              <div>
                <Typography level="title-md">Ваши данные</Typography>
                <div
                  style={{ display: "flex", justifyContent: "space-between" }}
                >
                  <Typography level="body-sm">Имя Фамилия Отчество</Typography>
                  <Typography level="body-sm">{fio}</Typography>
                </div>
                <div
                  style={{ display: "flex", justifyContent: "space-between" }}
                >
                  <Typography level="body-sm">Контактный номер</Typography>
                  <Typography level="body-sm">{phone}</Typography>
                </div>
                <div
                  style={{ display: "flex", justifyContent: "space-between" }}
                >
                  <Typography level="body-sm">Интересующие вопросы</Typography>
                  <Typography level="body-sm">
                    {filters.map((item) => item.title).join(", ")}
                  </Typography>
                </div>
              </div>
              <Divider sx={{ my: 1 }} />
              <div>
                <Typography level="title-md">Время визита</Typography>
                <div
                  style={{ display: "flex", justifyContent: "space-between" }}
                >
                  <Typography level="body-sm">
                    Рекомендуемое время визита
                  </Typography>
                  <Typography level="body-sm">9:00 – 13:00</Typography>
                </div>
                <div
                  style={{ display: "flex", justifyContent: "space-between" }}
                >
                  <Typography level="body-sm">Время на дорогу</Typography>
                  <Typography level="body-sm">~20 минут</Typography>
                </div>
                <div
                  style={{ display: "flex", justifyContent: "space-between" }}
                >
                  <Typography level="body-sm">Время в очереди</Typography>
                  <Typography level="body-sm">~10 минут</Typography>
                </div>
                <div
                  style={{ display: "flex", justifyContent: "space-between" }}
                >
                  <Typography level="body-sm">Время на обсуживание</Typography>
                  <Typography level="body-sm">~10 минут</Typography>
                </div>
              </div>
              <Divider sx={{ my: 1 }} />
              <div>
                <Typography level="title-md">Прочее</Typography>
                <div
                  style={{ display: "flex", justifyContent: "space-between" }}
                >
                  <Typography level="body-sm">Вы встанете в очередь</Typography>
                  <Typography level="body-sm">За {time} до прибытия</Typography>
                </div>
                <div
                  style={{ display: "flex", justifyContent: "space-between" }}
                >
                  <Typography level="body-sm">Напоминание о визите</Typography>
                  <Typography level="body-sm">{reminder}</Typography>
                </div>
                <div
                  style={{ display: "flex", justifyContent: "space-between" }}
                >
                  <Typography level="body-sm">
                    Вклад в благотворительность
                  </Typography>
                  <Typography level="body-sm">50 рублей</Typography>
                </div>
              </div>
            </div>
          </>
        )}
        <Button
          sx={{ borderRadius: 16, width: "100%", marginTop: "auto" }}
          size="lg"
          onClick={() => (showFinal ? finish() : nextStep())}
        >
          {showFinal ? "На главную" : "Далее"}
        </Button>
      </Sheet>
    </div>
  );
};
