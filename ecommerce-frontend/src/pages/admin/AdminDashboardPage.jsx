import React, {useEffect, useState} from 'react';

const AdminDashboardPage = () => {
    const [stats, setStats] = useState({totalUsers: 0, totalBuyers: 0, totalSellers: 0, blockedUsers: 0});
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        // Giả lập dữ liệu nhận được từ endpoint /A_User/list để hiển thị UI
        setTimeout(() => {
            setStats({totalUsers: 1550, totalBuyers: 1400, totalSellers: 150, blockedUsers: 12});
            setLoading(false);
        }, 300);
    }, []);

    if (loading) return <div className="text-center my-5"><h4>Đang tải dữ liệu hệ thống quản trị...</h4></div>;

    return (
        <div>
            <div className="pt-3 pb-2 mb-3 border-bottom">
                <h1 className="h2 text-dark">Hệ thống Thống kê Người dùng</h1>
            </div>

            <div className="row g-4">
                <div className="col-12 col-sm-6 col-lg-3">
                    <div className="card text-white bg-primary shadow-sm h-100 p-3">
                        <div className="card-body">
                            <h5 className="card-title text-white-50">Tổng thành viên</h5>
                            <h2 className="fw-bold mt-2">{stats.totalUsers} tài khoản</h2>
                        </div>
                    </div>
                </div>
                <div className="col-12 col-sm-6 col-lg-3">
                    <div className="card text-white bg-success shadow-sm h-100 p-3">
                        <div className="card-body">
                            <h5 className="card-title text-white-50">Tài khoản Người mua</h5>
                            <h2 className="fw-bold mt-2">{stats.totalBuyers} Buyer</h2>
                        </div>
                    </div>
                </div>
                <div className="col-12 col-sm-6 col-lg-3">
                    <div className="card text-white bg-info shadow-sm h-100 p-3">
                        <div className="card-body">
                            <h5 className="card-title text-white-50">Đối tác Người bán</h5>
                            <h2 className="fw-bold mt-2">{stats.totalSellers} Seller</h2>
                        </div>
                    </div>
                </div>
                <div className="col-12 col-sm-6 col-lg-3">
                    <div className="card text-white bg-danger shadow-sm h-100 p-3">
                        <div className="card-body">
                            <h5 className="card-title text-white-50">Tài khoản bị khóa</h5>
                            <h2 className="fw-bold mt-2">{stats.blockedUsers} vi phạm</h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default AdminDashboardPage;