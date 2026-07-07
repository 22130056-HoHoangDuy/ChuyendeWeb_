import React, {useEffect, useState} from 'react';

const BuyerManagementPage = () => {
    const [buyers, setBuyers] = useState([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        // Mock data giả lập cấu trúc response của anh
        setBuyers([
            {
                id: 1,
                avatar: "https://i.pravatar.cc/50?img=1",
                name: "Nguyễn Thu Hà",
                email: "ha.nguyen@gmail.com",
                phone: "0912345678",
                status: "ACTIVE"
            },
            {
                id: 2,
                avatar: "https://i.pravatar.cc/50?img=2",
                name: "Phạm Minh Hoàng",
                email: "hoangpm@gmail.com",
                phone: "0987654321",
                status: "BLOCKED"
            }
        ]);
        setLoading(false);
    }, []);

    const handleAction = (id, currentStatus) => {
        const nextStatus = currentStatus === 'ACTIVE' ? 'BLOCKED' : 'ACTIVE';
        if (window.confirm(`Anh có chắc chắn muốn thay đổi trạng thái user này thành ${nextStatus}?`)) {
            // Gọi hàm cập nhật PATCH lên BE
            alert(`Đã gửi yêu cầu đổi trạng thái của Buyer mã #${id} sang ${nextStatus}`);
            setBuyers(buyers.map(b => b.id === id ? {...b, status: nextStatus} : b));
        }
    };

    if (loading) return <div className="text-center my-5"><h4>Đang tải danh sách khách hàng...</h4></div>;

    return (
        <div>
            <div className="pt-3 pb-2 mb-3 border-bottom">
                <h1 className="h2 text-dark">👤 Quản lý thông tin Người mua (Buyer)</h1>
            </div>

            <div className="card shadow-sm border-0">
                <div className="table-responsive">
                    <table className="table table-hover align-middle mb-0 bg-white">
                        <thead className="table-light">
                        <tr>
                            <th>Avatar</th>
                            <th>Tên khách hàng</th>
                            <th>Email</th>
                            <th>Số điện thoại</th>
                            <th>Trạng thái</th>
                            <th className="text-center">Thao tác xử lý</th>
                        </tr>
                        </thead>
                        <tbody>
                        {buyers.map(buyer => (
                            <tr key={buyer.id}>
                                <td>
                                    <img src={buyer.avatar} alt="avatar" className="rounded-circle"
                                         style={{width: '40px', height: '40px'}}/>
                                </td>
                                <td><span className="fw-bold">{buyer.name}</span></td>
                                <td>{buyer.email}</td>
                                <td>{buyer.phone}</td>
                                <td>
                                        <span
                                            className={`badge ${buyer.status === 'ACTIVE' ? 'bg-success' : 'bg-danger'}`}>
                                            {buyer.status}
                                        </span>
                                </td>
                                <td className="text-center">
                                    {buyer.status === 'ACTIVE' ? (
                                        <button className="btn btn-sm btn-danger px-3"
                                                onClick={() => handleAction(buyer.id, buyer.status)}>Block</button>
                                    ) : (
                                        <button className="btn btn-sm btn-success px-3"
                                                onClick={() => handleAction(buyer.id, buyer.status)}>Unblock</button>
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

export default BuyerManagementPage;