import api from "../api";

export const getHomeProducts = async () => {
    const response = await api.get("/products/active");
    return response.data;
};

export const getProductDetail = async (id) => {
    const response = await api.get(`/products/detail/${id}`);
    return response.data;
};
export const addToCart = async (userId, sellerProductId, quantity) => {
    const response = await api.post(`/cart/add?userId=${userId}`, {
        sellerProductId,
        quantity
    });
    return response.data;
};