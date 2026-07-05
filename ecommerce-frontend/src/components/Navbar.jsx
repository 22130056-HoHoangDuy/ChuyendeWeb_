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
                        to="/"
                    >
                        Trang chủ
                    </Link>

                    <Link
                        className="nav-link"
                        to="/product"
                    >
                        Sản phẩm
                    </Link>

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