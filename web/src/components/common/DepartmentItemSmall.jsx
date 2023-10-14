import { Typography } from "@mui/joy";

export const DepartmentItemSmall = ({ item, onClick }) => {
  return (
    <div
      style={{
        display: "flex",
        alignItems: "start",
        cursor: "pointer",
      }}
      onClick={() => onClick && onClick()}
    >
      <div
        style={{
          borderRadius: "50%",
          width: "34px",
          height: "34px",
          backgroundColor: "#F0F4F8",
          display: "flex",
          alignItems: "center",
          justifyContent: "center",
          marginRight: "8px",
        }}
      >
        <img src="/src/assets/VTB_logo_ru.png" width="40" />
      </div>
      <Typography level="body-md">{item.address}</Typography>
    </div>
  );
};
