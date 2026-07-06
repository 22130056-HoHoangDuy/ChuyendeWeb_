import React from 'react';
import {Link, Outlet, useNavigate} from 'react-router-dom';

const AdminLayout = () => {
    const navigate = useNavigate();

    const handleLogout = () => {
        localStorage.clear();
        navigate('/login');
    };

    return (
        <div className="container-fluid p-0" style={{minHeight: '100vh', display: 'flex', flexDirection: 'column'}}>
            {/* TOP HEADER */}
            <header className="navbar navbar-dark sticky-top bg-danger flex-md-nowrap p-3 shadow">
                <Link className="navbar-brand col-md-3 col-lg-2 me-0 px-3 fs-5 fw-bold text-white"
                      to="/admin/dashboard">
                    🛡️ BabyDecor Admin
                </Link>
                <div className="d-flex align-items-center px-3">
                    <span className="text-white me-3">Quyền hạn: <strong className="text-warning">Quản trị viên</strong></span>
                    <button onClick={handleLogout} className="btn btn-sm btn-outline-light">Đăng xuất</button>
                </div>
            </header>

            <div className="row g-0 flex-grow-1">
                {/* SIDEBAR TRÁI CỐ ĐỊNH */}
                <nav className="col-md-3 col-lg-2 d-md-block bg-dark sidebar border-end">
                    <div className="position-sticky pt-3">
                        <ul className="nav flex-column p-2 gap-1">
                            <li className="nav-item">
                                <Link className="nav-link text-white p-3 rounded hover-opacity" to="/admin/dashboard"
                                      style={{background: 'rgba(255,255,255,0.05)'}}>
                                    📊 Dashboard Hệ thống
                                </Link>
                            </li>
                            <li className="nav-item">
                                <Link className="nav-link text-white p-3 rounded" to="/admin/buyers">
                                    👤 Quản lý Người mua (Buyer)
                                </Link>
                            </li>
                            <li className="nav-item">
                                <Link className="nav-link text-white p-3 rounded" to="/admin/sellers">
                                    🏪 Quản lý Người bán (Seller)
                                </Link>
                            </li>
                        </ul>
                    </div>
                </nav>

                {/* KHÔNG GIAN HIỂN THỊ CHỨC NĂNG CHÍNH */}
                <main className="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4 bg-light">
                    <Outlet/>
                </main>
            </div>
        </div>
    );
};

export default AdminLayout;