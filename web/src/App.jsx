import { CssVarsProvider } from "@mui/joy/styles";
import { appTheme } from "./theme";
import { AppContext } from "./providers/appContext";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";

const queryClient = new QueryClient();

const App = () => {
  return (
    <QueryClientProvider client={queryClient}>
      <CssVarsProvider theme={appTheme}>
        <AppContext.Provider value={{ value: 123 }}>test</AppContext.Provider>
      </CssVarsProvider>
    </QueryClientProvider>
  );
};

export default App;
