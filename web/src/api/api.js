import client from "./http";

export async function getDepartments(filters) {
  const response = await client.get(
    `/department${filters.length ? `?services=${filters.join(",")}` : ""}`
  );
  return response.data;
}

export async function getDepartment(id) {
  const response = await client.get(`/department/${id}`);

  return response.data;
}

export async function createTicket(payload) {
  const response = await client.post(`/ticket`, payload);

  return response;
}
