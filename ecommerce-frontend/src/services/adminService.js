import api from "../api";

export const adminService = {
    // 1. Lấy dữ liệu tổng quan cho Admin Dashboard
    getDashboardStats: async () => {
        // Gọi API danh sách tổng để Client tự tính toán hoặc BE trả về object tổng quan
        const response = await api.get("/A_User/list");
        return response.data;
    },

    // 2. Lấy danh sách Người mua (Buyer)
    getBuyers: async () => {
        const response = await api.get("/A_User/list?role=BUYER");
        return response.data;
    },

    // 3. Thay đổi trạng thái hoạt động của Người mua (Block / Unblock)
    updateBuyerStatus: async (id, status) => {
        const response = await api.patch(`/A_User/buyers/${id}/status`, {status});
        return response.data;
    },

    // 4. Lấy danh sách Người bán (Seller)
    getSellers: async () => {
        const response = await api.get("/A_User/list?role=SELLER");
        return response.data;
    },

    // 5. Thay đổi trạng thái hoạt động của Người bán (Suspend / Activate)
    updateSellerStatus: async (id, status) => {
        const response = await api.patch(`/A_User/sellers/${id}/status`, {status});
        return response.data;
    }
};