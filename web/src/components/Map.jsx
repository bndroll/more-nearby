import { useEffect, useRef, useState } from "react";
import { Map, Placemark, RouteButton, YMaps } from "react-yandex-maps";

import icon from "../assets/vtb_icon.png";
import iconWhite from "../assets/vtb_icon_white.png";

import selectedRed from "../assets/vtb_logo_sel_red.png";
import selectedYellow from "../assets/vtb_logo_sel_yellow.png";
import selectedGreen from "../assets/vtb_logo_sel_green.png";

import unselectedRed from "../assets/vtb_logo_un_red.png";
import unselectedYellow from "../assets/vtb_logo_un_yellow.png";
import unselectedGreen from "../assets/vtb_logo_un_green.png";
import { getStatus } from "../constants";

const selectedIconMap = {
  red: selectedRed,
  green: selectedGreen,
  yellow: selectedYellow,
};

const unselectedIconMap = {
  red: unselectedRed,
  yellow: unselectedYellow,
  green: unselectedGreen,
};

export const YMap = ({ departments, onSelect, selectedDep }) => {
  const ymap = useRef();

  const layout = useRef(null);

  const [mapState, setMapState] = useState({
    center: [51.53, 46.03],
    zoom: 12,
  });

  useEffect(() => {
    if (selectedDep) {
      setMapState({ center: [selectedDep.lat, selectedDep.lon], zoom: 15 });
    }
  }, [selectedDep]);

  return (
    <>
      <YMaps query={{ apikey: "320a7de8-f43a-4ec5-bdda-092da30ddbe1" }}>
        <Map
          options={{ autoFitToViewport: "always" }}
          modules={["templateLayoutFactory"]}
          width={window.innerWidth}
          height={window.innerHeight}
          state={mapState}
          onLoad={(ymaps) => {
            layout.current = ymaps.templateLayoutFactory.createClass(
              `<div style="width: 55px; height: 55px; background-color: #0C277D; border-radius: 50%; display: flex; justify-content: center; align-items: center">
                <img src="/src/assets/VTB_logo-white_ru.png" width="55" />
              </div>`
            );
          }}
        >
          <RouteButton options={{ float: "right" }} />
          {departments.map((item, index) => (
            <Placemark
              onClick={() => onSelect(item)}
              key={item.id}
              geometry={[item.lat, item.lon]}
              options={{
                iconLayout: "default#image",
                iconImageHref:
                  selectedDep && selectedDep.id === item.id
                    ? selectedIconMap[getStatus(item.target)]
                    : unselectedIconMap[getStatus(item.target)],
                iconImageSize: [55, 55],
              }}
            />
          ))}
        </Map>
      </YMaps>
    </>
  );
};
