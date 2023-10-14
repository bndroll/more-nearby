import { CssVarsProvider } from "@mui/joy/styles";
import { appTheme } from "./theme";
import { AppContext } from "./providers/appContext";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { YMap } from "./components/Map";
import { CreateTicket } from "./components/CreateTicket";
import { Button } from "@mui/joy";
import { useState } from "react";
import { SideBar } from "./components/SideBar";

const queryClient = new QueryClient();

const App = () => {
  const [showForm, setShowForm] = useState(false);
  const [selectedDep, setSelectedDep] = useState(null);
  const [departments, setDepartments] = useState([]);

  return (
    <QueryClientProvider client={queryClient}>
      <CssVarsProvider theme={appTheme}>
        <AppContext.Provider value={{ value: 123 }}>
          <YMap
            departments={departments}
            onSelect={(dep) => setSelectedDep(dep)}
            selectedDep={selectedDep}
          />
          <CreateTicket
            show={showForm}
            toggle={() => setShowForm((prev) => !prev)}
          />
          <Button
            onClick={() => setShowForm(true)}
            sx={{
              borderRadius: 16,
              position: "absolute",
              bottom: 10,
              right: 10,
            }}
            size="lg"
          >
            Оформить заявку
          </Button>
          <SideBar
            onLoadDeps={(deps) => setDepartments(deps)}
            selectedDep={selectedDep}
            onSelect={(dep) => setSelectedDep(dep)}
          />
        </AppContext.Provider>
      </CssVarsProvider>
    </QueryClientProvider>
  );
};

export default App;
