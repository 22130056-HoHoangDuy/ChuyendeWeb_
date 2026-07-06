import { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom'; // Import thêm useNavigate
import '../LoginPage.css';

const LoginPage = () => {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [showPassword, setShowPassword] = useState(false);
    const [errorMsg, setErrorMsg] = useState(''); // State để hiển thị lỗi
    const [isLoading, setIsLoading] = useState(false); // State để tạo hiệu ứng loading

    const navigate = useNavigate(); // Hook chuyển trang

    const handleLogin = async (e) => {
        e.preventDefault();
        setErrorMsg('');
        setIsLoading(true);

        const authRequest = {
            email: email,
            password: password,
            authType: 'PASSWORD' // Khớp với enum của backend
        };

        try {
            // Gọi API đến Spring Boot (đảm bảo port 8080 khớp với backend của bạn)
            const response = await fetch('http://localhost:8080/api/v1/auth/login', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(authRequest)
            });

            const data = await response.json();

            if (response.ok) {
                // 1. Lưu token vào LocalStorage để dùng cho các request sau
                localStorage.setItem('accessToken', data.accessToken);
                localStorage.setItem('refreshToken', data.refreshToken);

                // 2. Chuyển hướng người dùng về trang chủ
                navigate('/home');
            } else {
                // Backend trả về lỗi (ví dụ: sai mật khẩu, user không tồn tại)
                setErrorMsg(data.message || 'Email hoặc mật khẩu không chính xác!');
            }
        } catch (error) {
            console.error("Lỗi kết nối:", error);
            setErrorMsg('Không thể kết nối đến máy chủ. Vui lòng kiểm tra lại backend!');
        } finally {
            setIsLoading(false);
        }
    };

    return (
        <div className="login-container container-fluid p-0">
            <div className="row g-0 h-100">

                {/* Nửa bên trái: Hình nền */}
                <div className="col-md-6 d-none d-md-flex login-banner align-items-end">
                    <div className="banner-content text-white p-5">
                        <h1 className="fw-bold mb-3">KidsDecor</h1>
                        <p className="fs-5">
                            Đồ nội thất xinh xắn, an toàn cho không gian<br/>
                            phòng của bé yêu mỗi ngày.
                        </p>
                    </div>
                </div>

                {/* Nửa bên phải: Form đăng nhập */}
                <div className="col-md-6 d-flex justify-content-center align-items-center bg-white">
                    <div className="login-form-wrapper">
                        <h2 className="text-center fw-bold mb-5">Chào mừng trở lại!</h2>

                        {/* Hiển thị thông báo lỗi nếu có */}
                        {errorMsg && (
                            <div className="alert alert-danger py-2 small text-center" role="alert">
                                {errorMsg}
                            </div>
                        )}

                        <form onSubmit={handleLogin}>
                            <div className="mb-4">
                                <label className="form-label text-muted small fw-bold">ĐỊA CHỈ EMAIL</label>
                                <div className="input-group login-input-group">
                  <span className="input-group-text bg-transparent border-end-0">
                    <i className="bi bi-envelope text-muted"></i>
                  </span>
                                    <input
                                        type="email"
                                        className="form-control border-start-0 ps-0"
                                        placeholder="vidu@email.com"
                                        value={email}
                                        onChange={(e) => setEmail(e.target.value)}
                                        required
                                    />
                                </div>
                            </div>

                            <div className="mb-4">
                                <label className="form-label text-muted small fw-bold">MẬT KHẨU</label>
                                <div className="input-group login-input-group">
                  <span className="input-group-text bg-transparent border-end-0">
                    <i className="bi bi-lock text-muted"></i>
                  </span>
                                    <input
                                        type={showPassword ? "text" : "password"}
                                        className="form-control border-start-0 border-end-0 ps-0"
                                        placeholder="••••••••"
                                        value={password}
                                        onChange={(e) => setPassword(e.target.value)}
                                        required
                                    />
                                    <span
                                        className="input-group-text bg-transparent border-start-0"
                                        style={{cursor: 'pointer'}}
                                        onClick={() => setShowPassword(!showPassword)}
                                    >
                    <i className={showPassword ? "bi bi-eye-slash text-muted" : "bi bi-eye text-muted"}></i>
                  </span>
                                </div>
                            </div>

                            <button
                                type="submit"
                                className="btn btn-primary-custom w-100 py-2 mb-3"
                                disabled={isLoading}
                            >
                                {isLoading ? 'Đang xử lý...' : 'Đăng Nhập'}
                            </button>

                            <div className="text-end mb-5">
                                <Link to="/forgot-password" className="forgot-pwd-link small">Quên mật khẩu?</Link>
                            </div>

                            <div className="text-center">
                                <span className="text-muted small">Bạn mới biết đến KidsDecor? </span>
                                <Link to="/register" className="register-link fw-bold small">Tạo tài khoản</Link>
                            </div>
                        </form>
                    </div>
                </div>

            </div>
        </div>
    );
};

export default LoginPage;