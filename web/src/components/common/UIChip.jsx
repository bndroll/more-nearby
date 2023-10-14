import { Checkbox, Chip } from "@mui/joy";

export const UIChip = ({
  checked,
  onChange,
  label,
  checkedColor,
  uncheckedColor,
  type = "primary",
}) => {
  return (
    <Chip
      variant="soft"
      sx={{ mr: 1, mb: 1 }}
      color={checked ? type : "neutral"}
      size="md"
    >
      <Checkbox
        color={checked ? type : "neutral"}
        variant="solid"
        label={label}
        disableIcon
        overlay
        checked={checked}
        onChange={(e) => onChange && onChange(e)}
        sx={{
          color: checked ? checkedColor : uncheckedColor,
          fontSize: "14px",
          fontWeight: 400,
        }}
      />
    </Chip>
  );
};
