import { useState, useEffect } from 'react';
import api from "../api.js";

const CartPage = () => {
    const [cart, setCart] = useState(null);
    const [loading, setLoading] = useState(true);

    // Lấy userId từ object 'user' trong localStorage
    const getUserId = () => {
        try {
            const userStr = localStorage.getItem("user");
            return userStr ? JSON.parse(userStr).id : null;
        } catch (e) {
            console.error("Lỗi parse user ID:", e);
            return null;
        }
    };

    const userId = getUserId();

    const fetchCart = async () => {
        if (!userId) {
            setLoading(false);
            return;
        }
        try {
            const response = await api.get(`/cart/summary?userId=${userId}`);
            setCart(response.data);
        } catch (error) {
            console.error("Lỗi tải giỏ hàng:", error);
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        if (userId) {
            fetchCart();
        }
    }, [userId]); // Chỉ chạy lại khi userId thay đổi

    const updateQuantity = async (productId, delta) => {
        try {
            await api.put(`/cart/update-quantity?userId=${userId}&sellerProductId=${productId}&delta=${delta}`);
            fetchCart(); // Load lại dữ liệu mới nhất
        } catch (error) {
            console.error("Lỗi cập nhật số lượng:", error);
        }
    };

    const removeItem = async (productId) => {
        try {
            await api.delete(`/cart/remove/${productId}?userId=${userId}`);
            fetchCart();
        } catch (error) {
            console.error("Lỗi xóa sản phẩm:", error);
        }
    };

    if (loading) return <div className="container mt-5 text-center">Đang tải giỏ hàng...</div>;

    return (
        <div className="container mt-5">
            <h2 className="fw-bold mb-4">Giỏ hàng của bạn</h2>

            {(!cart || !cart.items || cart.items.length === 0) ? (
                <div className="text-center py-5">
                    <p className="text-muted fs-4">Giỏ hàng của bạn đang trống!</p>
                    <a href="/home" className="btn btn-primary mt-3 px-4">Tiếp tục mua sắm</a>
                </div>
            ) : (
                <>
                    <div className="table-responsive">
                        <table className="table align-middle">
                            <thead className="table-light">
                            <tr>
                                <th>Ảnh</th>
                                <th>Tên sản phẩm</th>
                                <th>Đơn giá</th>
                                <th>Số lượng</th>
                                <th>Thao tác</th>
                            </tr>
                            </thead>
                            <tbody>
                            {cart.items.map(item => (
                                <tr key={item.id}>
                                    <td><img src={item.imageUrl} width="60" className="rounded" alt={item.productName} /></td>
                                    <td className="fw-medium">{item.productName}</td>
                                    <td>{item.price?.toLocaleString()} đ</td>
                                    <td>
                                        <div className="input-group" style={{ maxWidth: "150px" }}>
                                            <button
                                                className="btn btn-outline-secondary btn-sm"
                                                onClick={() => updateQuantity(item.sellerProductId, -1)}
                                            >-</button>
                                            <input
                                                type="text"
                                                className="form-control form-control-sm text-center"
                                                value={item.quantity}
                                                readOnly
                                            />
                                            <button
                                                className="btn btn-outline-secondary btn-sm"
                                                onClick={() => updateQuantity(item.sellerProductId, 1)}
                                            >+</button>
                                        </div>
                                    </td>
                                    <td>
                                        <button
                                            onClick={() => removeItem(item.sellerProductId)}
                                            className="btn btn-outline-danger btn-sm"
                                        >Xóa</button>
                                    </td>
                                </tr>
                            ))}
                            </tbody>
                        </table>
                    </div>

                    <div className="mt-4 p-3 border-top d-flex justify-content-end align-items-center">
                        <h4 className="fw-bold me-4">
                            Tổng tiền: <span className="text-danger">{cart.totalPrice?.toLocaleString()} đ</span>
                        </h4>
                        <button className="btn btn-success px-5 py-2">Thanh toán</button>
                    </div>
                </>
            )}
        </div>
    );
};

export default CartPage;