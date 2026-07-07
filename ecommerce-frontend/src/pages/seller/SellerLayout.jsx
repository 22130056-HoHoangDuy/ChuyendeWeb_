import React from 'react';
import { Link, Outlet, useNavigate } from 'react-router-dom';

const SellerLayout = () => {
    const navigate = useNavigate();
    // Giả sử anh lưu tên người bán trong localStorage sau khi login thành công
    const sellerName = localStorage.getItem("username") || "Kênh Người Bán";

    const handleLogout = () => {
        localStorage.clear(); // Xóa token, username...
        navigate('/login');
    };

    return (
        <div className="container-fluid p-0" style={{ minHeight: '100vh', display: 'flex', flexDirection: 'column' }}>
            {/* TOP HEADER */}
            <header className="navbar navbar-dark sticky-top bg-dark flex-md-nowrap p-3 shadow">
                <Link className="navbar-brand col-md-3 col-lg-2 me-0 px-3 fs-5 fw-bold text-info" to="/seller/dashboard">
                    🧸 BabyDecor Seller
                </Link>
                <div className="d-flex align-items-center px-3">
                    <span className="text-white me-3">Xin chào, <strong className="text-warning">{sellerName}</strong></span>
                    <button onClick={handleLogout} className="btn btn-sm btn-outline-danger">Đăng xuất</button>
                </div>
            </header>

            <div className="row g-0 flex-grow-1">
                {/* SIDEBAR TRÁI */}
                <nav id="sidebarMenu" className="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse border-end">
                    <div className="position-sticky pt-3">
                        <ul className="nav flex-column p-2 gap-1">
                            <li className="nav-item">
                                <Link className="nav-link text-dark p-2 rounded hover-bg" to="/seller/dashboard">
                                    📊 Dashboard tổng quan
                                </Link>
                            </li>
                            <li className="nav-item">
                                <Link className="nav-link text-dark p-2 rounded" to="/seller/products">
                                    📦 Sản phẩm của tôi
                                </Link>
                            </li>
                            <li className="nav-item">
                                <Link className="nav-link text-dark p-2 rounded" to="/seller/products/create">
                                    ➕ Thêm sản phẩm mới
                                </Link>
                            </li>
                            <li className="nav-item">
                                <Link className="nav-link text-dark p-2 rounded" to="/seller/orders">
                                    📑 Quản lý đơn hàng
                                </Link>
                            </li>
                            <li className="nav-item">
                                <Link className="nav-link text-dark p-2 rounded" to="/seller/revenue">
                                    💰 Thống kê doanh thu
                                </Link>
                            </li>
                            <li className="nav-item">
                                <Link className="nav-link text-dark p-2 rounded" to="/seller/top-selling">
                                    ⭐ Top sản phẩm bán chạy
                                </Link>
                            </li>
                        </ul>
                    </div>
                </nav>

                {/* NƠI HIỂN THỊ CÁC TRANG CON ĐỘNG */}
                <main className="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4 bg-white">
                    <Outlet />
                </main>
            </div>
        </div>
    );
};

export default SellerLayout;