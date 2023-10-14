import { extendTheme } from "@mui/joy";

export const appTheme = extendTheme({
  colorSchemes: {
    light: {
      palette: {
        primary: {
          solidBg: "#0C277D",
          solidHoverBg: "#3A5296",
          solidActiveBg: "#0A1F64",
        },
        neutral: {
          solidBg: "#F0F4F8",
          solidHoverBg: "#DDE7EE",
          solidActiveBg: "#F0F4F8",
        },
        danger: {
          solidBg: "#C41C1C",
        },
      },
    },
    dark: {
      palette: {
        primary: {
          solidBg: "#0C277D",
          solidHoverBg: "#3A5296",
          solidActiveBg: "#0A1F64",
        },
        neutral: {
          solidBg: "#F0F4F8",
        },
      },
    },
  },
});
