import React, {useEffect, useState} from 'react';

const SellerManagementPage = () => {
    const [sellers, setSellers] = useState([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        // Dữ liệu giả lập đồng bộ cấu trúc API của admin
        setSellers([
            {id: 10, name: "Shop Cũi Gỗ Bé Yêu", email: "cuigo.decor@gmail.com", phone: "0901112222", status: "ACTIVE"},
            {
                id: 11,
                name: "Thế Giới Đèn Ngủ Trẻ Em",
                email: "denngu.kids@gmail.com",
                phone: "0903334444",
                status: "SUSPENDED"
            }
        ]);
        setLoading(false);
    }, []);

    const handleAction = (id, currentStatus) => {
        const nextStatus = currentStatus === 'ACTIVE' ? 'SUSPENDED' : 'ACTIVE';
        if (window.confirm(`Xác nhận chuyển trạng thái shop này sang ${nextStatus}?`)) {
            alert(`Đã gửi yêu cầu xử lý shop #${id} thành ${nextStatus}`);
            setSellers(sellers.map(s => s.id === id ? {...s, status: nextStatus} : s));
        }
    };

    if (loading) return <div className="text-center my-5"><h4>Đang tải danh sách đối tác...</h4></div>;

    return (
        <div>
            <div className="pt-3 pb-2 mb-3 border-bottom">
                <h1 className="h2 text-dark">🏪 Quản lý đối tác Người bán (Seller)</h1>
            </div>

            <div className="card shadow-sm border-0">
                <div className="table-responsive">
                    <table className="table table-hover align-middle mb-0 bg-white">
                        <thead className="table-light">
                        <tr>
                            <th>Tên Shop / Cửa hàng</th>
                            <th>Email liên hệ</th>
                            <th>Số điện thoại</th>
                            <th>Trạng thái sàn</th>
                            <th className="text-center">Thao tác quản trị</th>
                        </tr>
                        </thead>
                        <tbody>
                        {sellers.map(seller => (
                            <tr key={seller.id}>
                                <td><span className="fw-bold text-primary">{seller.name}</span></td>
                                <td>{seller.email}</td>
                                <td>{seller.phone}</td>
                                <td>
                                        <span
                                            className={`badge ${seller.status === 'ACTIVE' ? 'bg-success' : 'bg-warning text-dark'}`}>
                                            {seller.status}
                                        </span>
                                </td>
                                <td className="text-center">
                                    {seller.status === 'ACTIVE' ? (
                                        <button className="btn btn-sm btn-outline-danger"
                                                onClick={() => handleAction(seller.id, seller.status)}>Suspend</button>
                                    ) : (
                                        <button className="btn btn-sm btn-success"
                                                onClick={() => handleAction(seller.id, seller.status)}>Activate</button>
                                    )}
                                </td>
                            </tr>
                        ))}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    );
};

export default SellerManagementPage;