import { ArrowBack } from "@mui/icons-material";
import { Typography, Button } from "@mui/joy";
import { useEffect, useState } from "react";
import { BarChart, Bar, XAxis } from "recharts";
import { getDepartment } from "../api/api";
import {
  statusToColor,
  statusToText,
  getStatus,
  statusToType,
  getStatusFromGraph,
} from "../constants";
import { UIChip } from "./common/UIChip";

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

const windowQueue = [
  {
    title: "Кредиты",
    type: "credit",
    waitTime: 10,
    status: "green",
    peopleCount: 3,
  },
  {
    title: "Карты",
    type: "cards",
    waitTime: 45,
    status: "red",
    peopleCount: 6,
  },
  {
    title: "Ипотека",
    type: "mortgage",
    waitTime: 25,
    status: "yellow",
    peopleCount: 3,
  },
  {
    title: "Автокредиты",
    type: "autoCredit",
    waitTime: 40,
    status: "yellow",
    peopleCount: 2,
  },
  {
    title: "Вклады и счета",
    type: "depositAccounts",
    waitTime: 10,
    status: "green",
    peopleCount: 1,
  },
  {
    title: "Инвестиции",
    type: "investment",
    waitTime: 5,
    status: "green",
    peopleCount: 1,
  },
  {
    title: "Онлайн сервисы",
    type: "onlineServices",
    waitTime: 15,
    status: "green",
    peopleCount: 2,
  },
  {
    title: "Платежи и переводы",
    type: "payments",
    waitTime: 20,
    status: "green",
    peopleCount: 3,
  },
];

export const SelectedDep = ({ selectedDep, onSelect }) => {
  const [selected, setSelected] = useState(null);

  useEffect(async () => {
    if (selectedDep) {
      const dep = await getDepartment(selectedDep.id);
      setSelected(dep);
    }
  }, [selectedDep]);
  return (
    <>
      {selected && (
        <div>
          <div>
            <ArrowBack
              onClick={() => onSelect(null)}
              sx={{ cursor: "pointer" }}
            />
          </div>
          <Typography level="title-lg">{selected.title}</Typography>
          <div
            style={{
              display: "flex",
              justifyContent: "space-between",
              alignItems: "center",
            }}
          >
            <Typography level="body-xs">{selected.address}</Typography>
          </div>
          <div style={{ marginTop: "8px" }}>
            <UIChip
              label={statusToText[getStatusFromGraph(selected.graph)]}
              checked={true}
              checkedColor="white"
              type={statusToType[getStatusFromGraph(selected.graph)]}
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
            <BarChart width={350} height={140} data={selected.graph}>
              <XAxis dataKey="num" />
              <Bar dataKey="value" fill="#9CA9CA" barSize={35} />
            </BarChart>
          </div>
          <Button size="lg">Оформить заявку</Button>
          <div>
            <Typography level="title-lg" sx={{ mt: 3, mb: 1 }}>
              Очереди в отделениях
            </Typography>
            <div
              style={{
                display: "grid",
                gridTemplateColumns: "1fr 1fr",
                gap: "8px",
                overflowY: "scroll",
              }}
            >
              {selected.queues.map((item, index) => (
                <div
                  style={{
                    border: "1px solid #CDD7E1",
                    borderRadius: "8px",
                    padding: "8px",
                  }}
                >
                  <Typography level="body-sm" sx={{ fontWeight: 600 }}>
                    {item.tagTitle}
                  </Typography>
                  <div
                    style={{ display: "flex", justifyContent: "space-between" }}
                  >
                    <Typography level="body-xs">В очереди</Typography>
                    <Typography level="body-xs">
                      {item.analytic.queueCount} чел.
                    </Typography>
                  </div>
                  <div
                    style={{ display: "flex", justifyContent: "space-between" }}
                  >
                    <Typography level="body-xs">Время ожидания</Typography>
                    <Typography
                      level="body-xs"
                      sx={{
                        color:
                          statusToColor[getStatus(item.analytic.queueCount)],
                      }}
                    >
                      {item.analytic.queueCount} минут
                    </Typography>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </div>
      )}
    </>
  );
};
