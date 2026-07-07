import React, { useEffect, useState } from 'react';
import { sellerService } from '../../services/sellerService';

const SellerOrdersPage = () => {
    const [orders, setOrders] = useState([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        // Mai kết nối DB: sellerService.getOrders().then(res => setOrders(res)).catch(...)
        // Hiện tại giả lập data để hiển thị giao diện mẫu
        setOrders([
            { id: 101, customer: "Nguyễn Văn A", total: 450000, status: "PENDING" },
            { id: 102, customer: "Trần Thị B", total: 1250000, status: "PROCESSING" },
            { id: 103, customer: "Lê Văn C", total: 890000, status: "SHIPPING" }
        ]);
        setLoading(false);
    }, []);

    const handleStatusChange = (id, nextStatus) => {
        // Mai kết nối API PATCH: sellerService.updateOrderStatus(id, nextStatus)
        alert(`Cập nhật đơn hàng #${id} sang trạng thái: ${nextStatus}`);
        setOrders(orders.map(order => order.id === id ? { ...order, status: nextStatus } : order));
    };

    const getBadgeClass = (status) => {
        switch (status) {
            case 'PENDING': return 'bg-warning text-dark';
            case 'PROCESSING': return 'bg-info text-white';
            case 'SHIPPING': return 'bg-primary';
            case 'DELIVERED': return 'bg-success';
            case 'CANCELLED': return 'bg-danger';
            default: return 'bg-secondary';
        }
    };

    if (loading) return <div className="text-center my-5"><h4>Đang tải dữ liệu đơn hàng...</h4></div>;

    return (
        <div>
            <div className="pt-3 pb-2 mb-3 border-bottom">
                <h1 className="h2 text-primary">📑 Quản lý đơn hàng của Shop</h1>
            </div>

            <div className="card shadow-sm">
                <div className="card-body p-0">
                    <div className="table-responsive">
                        <table className="table table-hover align-middle mb-0">
                            <thead className="table-dark">
                            <tr>
                                <th>Mã đơn hàng</th>
                                <th>Tên khách hàng</th>
                                <th>Tổng tiền</th>
                                <th>Trạng thái</th>
                                <th className="text-center">Cập nhật nhanh trạng thái</th>
                            </tr>
                            </thead>
                            <tbody>
                            {orders.map(order => (
                                <tr key={order.id}>
                                    <td><strong>#{order.id}</strong></td>
                                    <td>{order.customer}</td>
                                    <td className="fw-bold text-danger">{order.total?.toLocaleString('vi-VN')} đ</td>
                                    <td>
                                            <span className={`badge ${getBadgeClass(order.status)}`}>
                                                {order.status}
                                            </span>
                                    </td>
                                    <td>
                                        <div className="d-flex justify-content-center gap-1">
                                            <button className="btn btn-sm btn-outline-info" onClick={() => handleStatusChange(order.id, 'PROCESSING')} disabled={order.status !== 'PENDING'}>Duyệt</button>
                                            <button className="btn btn-sm btn-outline-primary" onClick={() => handleStatusChange(order.id, 'SHIPPING')} disabled={order.status !== 'PROCESSING'}>Giao hàng</button>
                                            <button className="btn btn-sm btn-outline-success" onClick={() => handleStatusChange(order.id, 'DELIVERED')} disabled={order.status !== 'SHIPPING'}>Hoàn thành</button>
                                            <button className="btn btn-sm btn-outline-danger" onClick={() => handleStatusChange(order.id, 'CANCELLED')} disabled={order.status === 'DELIVERED' || order.status === 'CANCELLED'}>Hủy đơn</button>
                                        </div>
                                    </td>
                                </tr>
                            ))}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default SellerOrdersPage;