import api from "../api";

// Cấu hình Interceptor riêng cho các request của Seller để tự động đính kèm Token JWT
api.interceptors.request.use(
    (config) => {
        const token = localStorage.getItem("token"); // Hoặc sessionStorage tùy anh lưu khi login
        if (token) {
            config.headers["Authorization"] = `Bearer ${token}`;
        }
        return config;
    },
    (error) => {
        return Promise.reject(error);
    }
);

export const sellerService = {
    // 1. Dashboard tổng quan
    getDashboard: async () => {
        const response = await api.get("/seller/dashboard");
        return response.data;
    },

    // 2. Danh sách sản phẩm của Shop
    getProducts: async () => {
        const response = await api.get("/seller/products");
        return response.data;
    },

    // 3. Tạo sản phẩm mới
    createProduct: async (productData) => {
        const response = await api.post("/seller/products", productData);
        return response.data;
    },

    // 4. Sửa sản phẩm
    editProduct: async (id, productData) => {
        const response = await api.put(`/seller/products/${id}`, productData);
        return response.data;
    },

    // 5. Quản lý Đơn hàng (Lấy danh sách đơn)
    getOrders: async () => {
        const response = await api.get("/seller/orders");
        return response.data;
    },

    // 6. Cập nhật trạng thái Đơn hàng
    updateOrderStatus: async (id, status) => {
        const response = await api.patch(`/seller/orders/${id}/status`, {status});
        return response.data;
    },

    // 7. Thống kê doanh thu
    getRevenue: async () => {
        const response = await api.get("/seller/revenue");
        return response.data;
    },

    // 8. Top sản phẩm bán chạy
    getTopSelling: async () => {
        const response = await api.get("/seller/top-selling");
        return response.data;
    }
};