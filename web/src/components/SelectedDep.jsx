import { ArrowBack } from "@mui/icons-material";
import { Typography, Button } from "@mui/joy";

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
    </div>
  );
};
