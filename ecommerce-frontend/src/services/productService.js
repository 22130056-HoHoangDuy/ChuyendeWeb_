import api from "../api";

export const getHomeProducts = async () => {
    const response = await api.get("/products/active");
    return response.data;
};
export const getProductDetail = (id) => {
    return api.get(`/products/detail/${id}`);
};