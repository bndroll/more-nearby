import Modal from "@mui/joy/Modal";
import ModalDialog from "@mui/joy/ModalDialog";
import DialogTitle from "@mui/joy/DialogTitle";
import DialogContent from "@mui/joy/DialogContent";
import ModalClose from "@mui/joy/ModalClose";
import Typography from "@mui/joy/Typography";
import Autocomplete from "@mui/joy/Autocomplete";
import { useEffect, useState } from "react";
import { Button, Input } from "@mui/joy";
import { servicesList } from "../constants";

export const CreateTicket = ({ show, toggle }) => {
  const [isModalOpen, setModalOpen] = useState(show);
  const [fio, setFio] = useState("");
  const [selectedServices, setSelectedServices] = useState([]);
  const [phoneNumber, setPhoneNumber] = useState("");
  useEffect(() => {
    setModalOpen(true);
  }, []);

  return (
    <Modal open={show} onClose={toggle} size="lg">
      <ModalDialog variant="plain" sx={{ width: "1100px" }}>
        <ModalClose />
        <Typography level="h4">Оставить заявку</Typography>
        <Typography level="body-lg">
          <div
            style={{
              display: "flex",
              alignItems: "center",
            }}
          >
            <div>Добрый день, Я</div>
            <Input
              placeholder="ФИО"
              sx={{ ml: 1, borderRadius: 100, width: "300px" }}
              value={fio}
              onChange={(e) => setFio(e.target.value)}
            />
          </div>
          <div
            style={{
              display: "flex",
              alignItems: "center",
            }}
          >
            <div>хочу совершить визит в ваше банковское отделение</div>
          </div>
          <div
            style={{
              display: "flex",
              alignItems: "center",
            }}
          >
            <div>и хотел(а) бы обсудить следущие вопрос(ы)</div>
            <Autocomplete
              sx={{ ml: 1, borderRadius: 100, width: "400px" }}
              limitTags={2}
              multiple
              id="tags-default"
              placeholder="Услуги"
              options={servicesList}
              getOptionLabel={(option) => option.title}
              defaultValue={[]}
              onChange={(e, val) => setSelectedServices(val)}
            />
          </div>
          <div
            style={{
              display: "flex",
              alignItems: "center",
            }}
          >
            <div>
              При выборе наиболее подходящего отделения, учитывайте, что после
              визита я поеду
            </div>
          </div>
          <div
            style={{
              display: "flex",
              alignItems: "center",
            }}
          >
            <div>
              И да, если возникнет срочный вопрос, можно связаться со мной по
              телефону
            </div>
            <Input
              placeholder="Номер телефона"
              sx={{ ml: 1, borderRadius: 100, width: "200px" }}
              maxLength={11}
              value={phoneNumber}
              onChange={(e) => setPhoneNumber(e.target.value)}
            />
          </div>
          <div
            style={{
              display: "flex",
              justifyContent: "end",
              marginTop: "20px",
            }}
          >
            <Button sx={{ borderRadius: 100 }} size="lg">
              Показать отделения
            </Button>
          </div>
        </Typography>
      </ModalDialog>
    </Modal>
  );
};
