import { Link, useNavigate } from "react-router-dom"; // 1. Import thêm useNavigate

function Navbar() {
    const navigate = useNavigate(); // 2. Khởi tạo hook điều hướng

    // 3. Viết hàm xử lý sự kiện Đăng xuất
    const handleLogout = () => {
        // Xóa token khỏi bộ nhớ
        localStorage.removeItem('accessToken');
        localStorage.removeItem('refreshToken');

        // Đẩy người dùng về trang đăng nhập
        navigate('/login');
    };

    return (
        <nav className="navbar navbar-expand-lg navbar-light bg-light shadow-sm">
            <div className="container">

                <Link
                    className="navbar-brand fw-bold text-decoration-none"
                    to="/"
                >
                    Kid Decor
                </Link>

                <div className="ms-auto d-flex gap-3 align-items-center">

                    <Link
                        className="nav-link"
                        to="/home"
                    >
                        Trang chủ
                    </Link>

                    <Link
                        className="nav-link"
                        to="/product"
                    >
                        Sản phẩm
                    </Link>

                    {/* Nút chuyển sang trang Cá nhân */}
                    <Link
                        to="/profile"
                        className="text-decoration-none"
                    >
                        <button className="btn btn-outline-secondary">
                            👤 Hồ sơ
                        </button>
                    </Link>

                    {/* Nút Giỏ hàng */}
                    <Link
                        to="/cart"
                        className="text-decoration-none"
                    >
                        <button className="btn btn-outline-primary">
                            🛒 Giỏ hàng
                        </button>
                    </Link>

                    {/* Nút Đăng xuất */}
                    <button
                        onClick={handleLogout}
                        className="btn btn-outline-danger"
                    >
                        🚪 Đăng xuất
                    </button>

                </div>

            </div>
        </nav>
    );
}

export default Navbar;