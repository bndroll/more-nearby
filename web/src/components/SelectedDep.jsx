import { ArrowBack } from "@mui/icons-material";
import { Typography, Button } from "@mui/joy";
import { ResponsiveContainer, BarChart, Bar, XAxis } from "recharts";
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

export const SelectedDep = ({ selectedDep, onSelect }) => {
  return (
    <div>
      <div>
        <ArrowBack onClick={() => onSelect(null)} sx={{ cursor: "pointer" }} />
      </div>
      <Typography level="title-lg">{selectedDep.title}</Typography>
      <div
        style={{
          display: "flex",
          justifyContent: "space-between",
          alignItems: "center",
        }}
      >
        <Typography level="body-xs">{selectedDep.address}</Typography>
        <Button variant="soft" size="sm">
          <Typography level="body-xs">Построить маршрут</Typography>
        </Button>
      </div>
      <div style={{ marginTop: "8px" }}>
        <UIChip
          label="Высокая нагрузка"
          checked={true}
          checkedColor="white"
          type="danger"
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
        <BarChart width={350} height={140} data={chartData}>
          <XAxis dataKey="name" />
          <Bar dataKey="count" fill="#9CA9CA" barSize={35} />
        </BarChart>
      </div>
      <Button size="lg">Оформить заявку</Button>
    </div>
  );
};
