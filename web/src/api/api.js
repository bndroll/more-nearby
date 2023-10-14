import client from "./http";

export async function getDepartments(filters) {
  const response = await client.get(
    `/department${filters.length ? `?services=${filters.join(",")}` : ""}`
  );
  return response.data;
}
