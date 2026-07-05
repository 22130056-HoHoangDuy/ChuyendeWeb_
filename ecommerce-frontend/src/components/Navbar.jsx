import { Link } from "react-router-dom";

function Navbar() {
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

                    {/* Nút Giỏ hàng hiện tại */}
                    <Link
                        to="/cart"
                        className="text-decoration-none"
                    >
                        <button className="btn btn-outline-primary">
                            🛒 Giỏ hàng
                        </button>
                    </Link>

                </div>

            </div>
        </nav>
    );
}

export default Navbar;