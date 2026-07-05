import { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import './RegisterPage.css';

const RegisterPage = () => {
    const [formData, setFormData] = useState({
        fullName: '',
        email: '',
        phoneNumber: '', // Trùng khớp với @JsonProperty("phoneNumber") ở backend
        password: '',
        confirmPassword: ''
    });
    const [showPassword, setShowPassword] = useState(false);
    const [errorMsg, setErrorMsg] = useState('');
    const [isLoading, setIsLoading] = useState(false);

    const navigate = useNavigate();

    const handleChange = (e) => {
        setFormData({ ...formData, [e.target.name]: e.target.value });
    };

    const handleRegister = async (e) => {
        e.preventDefault();
        setErrorMsg('');

        // Kiểm tra mật khẩu xác nhận
        if (formData.password !== formData.confirmPassword) {
            setErrorMsg('Mật khẩu xác nhận không khớp!');
            return;
        }

        setIsLoading(true);

        try {
            const response = await fetch('http://localhost:8080/api/v1/auth/register', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    fullName: formData.fullName,
                    email: formData.email,
                    phoneNumber: formData.phoneNumber,
                    password: formData.password
                })
            });

            const data = await response.json();

            if (response.ok) {
                // Theo backend của bạn, đăng ký xong sẽ trả về luôn token
                // Nên chúng ta có thể tự động đăng nhập luôn và chuyển về trang chủ
                localStorage.setItem('accessToken', data.accessToken);
                localStorage.setItem('refreshToken', data.refreshToken);
                navigate('/');
            } else {
                // Hiển thị lỗi từ backend (ví dụ: email đã tồn tại, sai định dạng)
                setErrorMsg(data.message || 'Đăng ký thất bại, vui lòng kiểm tra lại thông tin!');
            }
        } catch (error) {
            console.error("Lỗi kết nối:", error);
            setErrorMsg('Không thể kết nối đến máy chủ. Vui lòng thử lại sau!');
        } finally {
            setIsLoading(false);
        }
    };

    return (
        <div className="register-container container-fluid p-0">
            <div className="row g-0 h-100">

                {/* Nửa bên trái: Hình nền */}
                <div className="col-md-6 d-none d-md-flex register-banner align-items-end">
                    <div className="banner-content text-white p-5">
                        <h1 className="fw-bold mb-3">KidsDecor</h1>
                        <p className="fs-5">
                            Cùng chúng tôi tạo nên những không gian<br/>
                            kỳ diệu cho tuổi thơ của bé.
                        </p>
                    </div>
                </div>

                {/* Nửa bên phải: Form đăng ký */}
                <div className="col-md-6 d-flex justify-content-center align-items-center bg-white overflow-auto">
                    <div className="register-form-wrapper py-4">
                        <h2 className="text-center fw-bold mb-4">Tạo Tài Khoản</h2>

                        {errorMsg && (
                            <div className="alert alert-danger py-2 small text-center" role="alert">
                                {errorMsg}
                            </div>
                        )}

                        <form onSubmit={handleRegister}>
                            <div className="mb-3">
                                <label className="form-label text-muted small fw-bold">HỌ VÀ TÊN</label>
                                <div className="input-group register-input-group">
                  <span className="input-group-text bg-transparent border-end-0">
                    <i className="bi bi-person text-muted"></i>
                  </span>
                                    <input
                                        type="text"
                                        name="fullName"
                                        className="form-control border-start-0 ps-0"
                                        placeholder="Nguyễn Văn A"
                                        value={formData.fullName}
                                        onChange={handleChange}
                                        required
                                    />
                                </div>
                            </div>

                            <div className="mb-3">
                                <label className="form-label text-muted small fw-bold">ĐỊA CHỈ EMAIL</label>
                                <div className="input-group register-input-group">
                  <span className="input-group-text bg-transparent border-end-0">
                    <i className="bi bi-envelope text-muted"></i>
                  </span>
                                    <input
                                        type="email"
                                        name="email"
                                        className="form-control border-start-0 ps-0"
                                        placeholder="vidu@email.com"
                                        value={formData.email}
                                        onChange={handleChange}
                                        required
                                    />
                                </div>
                            </div>

                            <div className="mb-3">
                                <label className="form-label text-muted small fw-bold">SỐ ĐIỆN THOẠI</label>
                                <div className="input-group register-input-group">
                  <span className="input-group-text bg-transparent border-end-0">
                    <i className="bi bi-telephone text-muted"></i>
                  </span>
                                    <input
                                        type="tel"
                                        name="phoneNumber"
                                        className="form-control border-start-0 ps-0"
                                        placeholder="0912345678"
                                        value={formData.phoneNumber}
                                        onChange={handleChange}
                                        pattern="[0-9]{10,11}"
                                        title="Số điện thoại phải bao gồm 10 hoặc 11 chữ số"
                                        required
                                    />
                                </div>
                            </div>

                            <div className="mb-3">
                                <label className="form-label text-muted small fw-bold">MẬT KHẨU</label>
                                <div className="input-group register-input-group">
                  <span className="input-group-text bg-transparent border-end-0">
                    <i className="bi bi-lock text-muted"></i>
                  </span>
                                    <input
                                        type={showPassword ? "text" : "password"}
                                        name="password"
                                        className="form-control border-start-0 border-end-0 ps-0"
                                        placeholder="Tối thiểu 6 ký tự"
                                        value={formData.password}
                                        onChange={handleChange}
                                        minLength="6"
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

                            <div className="mb-4">
                                <label className="form-label text-muted small fw-bold">XÁC NHẬN MẬT KHẨU</label>
                                <div className="input-group register-input-group">
                  <span className="input-group-text bg-transparent border-end-0">
                    <i className="bi bi-lock-fill text-muted"></i>
                  </span>
                                    <input
                                        type={showPassword ? "text" : "password"}
                                        name="confirmPassword"
                                        className="form-control border-start-0 ps-0"
                                        placeholder="Nhập lại mật khẩu"
                                        value={formData.confirmPassword}
                                        onChange={handleChange}
                                        required
                                    />
                                </div>
                            </div>

                            <button
                                type="submit"
                                className="btn btn-primary-custom w-100 py-2 mb-3"
                                disabled={isLoading}
                            >
                                {isLoading ? 'Đang đăng ký...' : 'Đăng Ký'}
                            </button>

                            <div className="text-center mt-3">
                                <span className="text-muted small">Đã có tài khoản? </span>
                                <Link to="/login" className="login-link fw-bold small">Đăng nhập tại đây</Link>
                            </div>
                        </form>
                    </div>
                </div>

            </div>
        </div>
    );
};

export default RegisterPage;