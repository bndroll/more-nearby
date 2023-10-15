export const servicesList = [
  {
    title: "Кредиты",
    type: "credit",
    prefix: "К",
    time: 10,
  },
  {
    title: "Карты",
    type: "cards",
    prefix: "КА",
    time: 10,
  },
  {
    title: "Ипотека",
    type: "mortgage",
    prefix: "И",
    time: 30,
  },
  {
    title: "Автокредиты",
    type: "autoCredit",
    prefix: "АК",
    time: 15,
  },
  {
    title: "Вклады и счета",
    type: "depositAccounts",
    prefix: "ВС",
    time: 15,
  },
  {
    title: "Инвестиции",
    type: "investment",
    prefix: "ИН",
    time: 10,
  },
  {
    title: "Онлайн сервисы",
    type: "onlineServices",
    prefix: "ОС",
    time: 10,
  },
  {
    title: "Платежи и переводы",
    type: "payments",
    prefix: "П",
    time: 10,
  },
];

export const statusToColor = {
  red: "#C41C1C",
  yellow: "#D37406",
  green: "#269226",
};

export const statusToText = {
  red: "Высокая нагрузка",
  yellow: "Средняя нагрузка",
  green: "Низкая нагрузка",
};

export const getStatus = (val) => {
  if (val <= 25) {
    return "green";
  }

  if (val > 25 && val <= 75) {
    return "yellow";
  }

  return "red";
};

export const statusToType = {
  green: "success",
  red: "danger",
  yellow: "warning",
};

export const getStatusFromGraph = (graph) => {
  const currentHour = new Date().getHours() - 1;
  const adjustedHour = currentHour > 21 || currentHour < 9 ? 21 : currentHour;
  const item = graph.find((item) => {
    return item.num === adjustedHour;
  });

  return getStatus(item.value);
};
