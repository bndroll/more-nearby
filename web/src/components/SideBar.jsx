import { Button, Checkbox, Chip, Sheet, Typography } from "@mui/joy";
import { servicesList } from "../constants";
import { useEffect, useState } from "react";
import { getDepartments } from "../api/api";
import { useDebounce } from "react-use";
import { SelectedDep } from "./SelectedDep";

export const SideBar = ({ onLoadDeps, selectedDep, onSelect }) => {
  const [filters, setFilters] = useState([]);
  const [departments, setDepartments] = useState([]);

  useDebounce(
    async () => {
      const data = await getDepartments(filters);
      setDepartments(data);
      onLoadDeps(data);
    },
    500,
    [filters]
  );

  return (
    <div
      style={{
        position: "fixed",
        top: 48,
        left: 24,
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
        }}
      >
        <Typography level="title-lg">Фильтры</Typography>
        <div style={{ paddingTop: "8px", color: "black" }}>
          {servicesList.map((item, index) => {
            const checked = filters.includes(item.type);
            return (
              <Chip
                key={index}
                variant="soft"
                sx={{ mr: 1, mb: 1 }}
                color={checked ? "primary" : "neutral"}
                size="md"
              >
                <Checkbox
                  variant="solid"
                  label={item.title}
                  disableIcon
                  overlay
                  checked={checked}
                  onChange={(e) => {
                    setFilters((prev) =>
                      !e.target.checked
                        ? prev.filter((n) => n !== item.type)
                        : [...prev, item.type]
                    );
                  }}
                  sx={{
                    color: checked ? "white" : "#0C277D",
                    fontSize: "14px",
                    fontWeight: 400,
                  }}
                />
              </Chip>
            );
          })}
        </div>
      </Sheet>
      <Sheet
        sx={{
          mt: 1,
          borderRadius: 16,
          boxShadow:
            "var(--joy-shadowRing, 0 0 #000),0px 2px 8px -2px rgba(var(--joy-shadowChannel, 21 21 21) / var(--joy-shadowOpacity, 0.08)),0px 20px 24px -4px rgba(var(--joy-shadowChannel, 21 21 21) / var(--joy-shadowOpacity, 0.08))",
          background: "white",
          px: 2,
          py: 2,
        }}
      >
        {selectedDep ? (
          <SelectedDep
            selectedDep={selectedDep}
            onSelect={(item) => onSelect(item)}
          />
        ) : (
          <div>
            <Typography level="title-lg">
              Наиболее подходящее отделение
            </Typography>
            <Typography level="title-md">Другие отделения</Typography>
            <div style={{ marginTop: "8px" }}>
              {departments.map((item, index) => (
                <div
                  key={item.id}
                  style={{
                    padding: "8px",
                  }}
                  className="department-item-small"
                >
                  <div
                    style={{
                      display: "flex",
                      alignItems: "start",
                      cursor: "pointer",
                    }}
                    onClick={() => onSelect(item)}
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
                  <div style={{ marginTop: "16px" }}>
                    <Button
                      size="sm"
                      variant="soft"
                      sx={{ borderRadius: 10, mr: 1 }}
                    >
                      <Typography level="body-xs" color="primary">
                        Оформить заявку
                      </Typography>
                    </Button>
                    <Button size="sm" variant="soft" sx={{ borderRadius: 10 }}>
                      <Typography level="body-xs">Об отделении</Typography>
                    </Button>
                  </div>
                </div>
              ))}
            </div>
          </div>
        )}
      </Sheet>
    </div>
  );
};
