import { useState, useEffect, useCallback } from 'react'; // Bổ sung useCallback
import { useNavigate } from 'react-router-dom';
import './ProfilePage.css';

const ProfilePage = () => {
    const [profile, setProfile] = useState(null);
    const [isEditing, setIsEditing] = useState(false);
    const [loading, setLoading] = useState(true);
    const [message, setMessage] = useState({ type: '', text: '' });
    const [formData, setFormData] = useState({
        fullName: '', phone: '', age: '', avatar: '',
        country: '', province: '', district: '', street: '', houseNumber: '' // Thêm các trường địa chỉ
    });
    const navigate = useNavigate();
    useEffect(() => {
        if (message.text) {
            const timer = setTimeout(() => {
                setMessage({ type: '', text: '' });
            }, 4000); // 4000ms = 4 giây

            return () => clearTimeout(timer);
        }
    }, [message.text]);
    const fetchProfile = useCallback(async () => {
        const token = localStorage.getItem('accessToken');
        if (!token) {
            navigate('/login');
            return;
        }

        try {
            const response = await fetch('http://localhost:8080/api/v1/user/profile', {
                method: 'GET',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json'
                }
            });

            if (response.ok) {
                const data = await response.json();
                setProfile(data);
                const firstAddress = (data.addresses && data.addresses.length > 0) ? data.addresses[0] : {};

                setFormData({
                    fullName: data.fullName || '',
                    phone: data.phone || '',
                    age: data.age || '',
                    avatar: data.avatar || '',
                    country: firstAddress.country || '',
                    province: firstAddress.province || '',
                    district: firstAddress.district || '',
                    street: firstAddress.street || '',
                    houseNumber: firstAddress.houseNumber || ''
                });
            }
        } catch (error) {
            console.error("Lỗi lấy thông tin:", error);
            setMessage({ type: 'danger', text: 'Không thể kết nối đến máy chủ.' });
        } finally {
            setLoading(false);
        }
    }, [navigate]); // Đưa navigate vào mảng phụ thuộc

    // 2. KHAI BÁO HÀM ASYNC BÊN TRONG useEffect
    useEffect(() => {
        const initFetch = async () => {
            await fetchProfile(); // Thêm await để giải quyết lỗi set-state-in-effect
        };
        initFetch();
    }, [fetchProfile]); // Đưa fetchProfile vào đây

    const handleInputChange = (e) => {
        setFormData({ ...formData, [e.target.name]: e.target.value });
    };

    const handleAvatarUpload = async (e) => {
        const file = e.target.files[0];
        if (!file) return;

        setMessage({ type: 'info', text: 'Đang tải ảnh lên Cloudinary...' });
        const token = localStorage.getItem('accessToken');

        const formDataUpload = new FormData();
        formDataUpload.append('file', file);

        try {
            const response = await fetch('http://localhost:8080/api/v1/user/upload-avatar', {
                method: 'POST',
                headers: {
                    'Authorization': `Bearer ${token}`
                },
                body: formDataUpload
            });

            if (response.ok) {
                const data = await response.json();

                setProfile({ ...profile, avatar: data.avatar });
                setFormData({ ...formData, avatar: data.avatar });

                setMessage({ type: 'success', text: 'Cập nhật ảnh đại diện thành công!' });
            } else {
                setMessage({ type: 'danger', text: 'Không thể tải ảnh lên!' });
            }
        } catch (error) {
            console.error("Lỗi upload ảnh:", error);
            setMessage({ type: 'danger', text: 'Lỗi kết nối máy chủ khi tải ảnh.' });
        }
    };

    const handleUpdateProfile = async (e) => {
        e.preventDefault();
        setMessage({ type: '', text: '' });
        const token = localStorage.getItem('accessToken');

        try {
            const response = await fetch('http://localhost:8080/api/v1/user/update_profile', {
                method: 'PUT',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    fullName: formData.fullName,
                    phone: formData.phone,
                    age: formData.age === '' ? null : parseInt(formData.age),
                    avatar: formData.avatar,
                    address: { // <--- Đối tượng này khớp với cấu trúc mong đợi của Backend
                        country: formData.country,
                        province: formData.province,
                        district: formData.district,
                        street: formData.street,
                        houseNumber: formData.houseNumber
                    }
                })
            });

            if (response.ok) {
                setMessage({ type: 'success', text: 'Cập nhật thông tin thành công!' });
                setIsEditing(false);
                await fetchProfile(); // 3. Thêm await vào đây để khắc phục lỗi "Missing await"
            } else {
                setMessage({ type: 'danger', text: 'Cập nhật thất bại, vui lòng thử lại.' });
            }
        } catch (error) {
            console.error("Lỗi cập nhật:", error);
            setMessage({ type: 'danger', text: 'Lỗi kết nối đến máy chủ.' });
        }
    };

    if (loading) {
        return <div className="container mt-5 text-center">Đang tải thông tin...</div>;
    }

    return (
        <div className="container py-5 profile-container">
            <div className="row justify-content-center">
                <div className="col-md-8 col-lg-6">
                    <div className="card shadow-sm border-0 rounded-4">
                        <div className="card-body p-5">

                            <div className="text-center mb-4">
                                <img
                                    src={profile?.avatar || "https://ui-avatars.com/api/?name=" + (profile?.fullName || "User") + "&background=6C5CE7&color=fff&size=120"}
                                    alt="Avatar"
                                    className="rounded-circle profile-avatar mb-3 shadow-sm"
                                />
                                <h3 className="fw-bold">{profile?.fullName || 'Người dùng KidsDecor'}</h3>
                                <p className="text-muted">{profile?.email}</p>
                            </div>

                            {message.text && (
                                <div className={`alert alert-${message.type === 'info' ? 'primary' : message.type} py-2 small`} role="alert">
                                    {message.text}
                                </div>
                            )}

                            <form onSubmit={handleUpdateProfile}>
                                {/* Phần thông tin cơ bản hiện có */}
                                <div className="mb-3">
                                    <label className="form-label text-muted small fw-bold">HỌ VÀ TÊN</label>
                                    <input
                                        type="text"
                                        className="form-control"
                                        name="fullName"
                                        value={formData.fullName}
                                        onChange={handleInputChange}
                                        disabled={!isEditing}
                                    />
                                </div>

                                <div className="row mb-3">
                                    <div className="col-md-6">
                                        <label className="form-label text-muted small fw-bold">SỐ ĐIỆN THOẠI</label>
                                        <input
                                            type="tel"
                                            className="form-control"
                                            name="phone"
                                            value={formData.phone}
                                            onChange={handleInputChange}
                                            disabled={!isEditing}
                                        />
                                    </div>
                                    <div className="col-md-6 mt-3 mt-md-0">
                                        <label className="form-label text-muted small fw-bold">TUỔI</label>
                                        <input
                                            type="number"
                                            className="form-control"
                                            name="age"
                                            value={formData.age}
                                            onChange={handleInputChange}
                                            disabled={!isEditing}
                                        />
                                    </div>
                                </div>

                                {/* BỔ SUNG: Phần nhập Địa chỉ */}
                                <h5 className="mt-5 mb-3 fw-bold text-muted border-bottom pb-2">ĐỊA CHỈ GIAO HÀNG</h5>

                                <div className="row mb-3">
                                    <div className="col-md-6">
                                        <label className="form-label text-muted small fw-bold">QUỐC GIA</label>
                                        <input type="text" className="form-control" name="country"
                                               value={formData.country} onChange={handleInputChange} disabled={!isEditing} />
                                    </div>
                                    <div className="col-md-6 mt-3 mt-md-0">
                                        <label className="form-label text-muted small fw-bold">TỈNH / THÀNH PHỐ</label>
                                        <input type="text" className="form-control" name="province"
                                               value={formData.province} onChange={handleInputChange} disabled={!isEditing} />
                                    </div>
                                </div>

                                <div className="row mb-4">
                                    <div className="col-md-4">
                                        <label className="form-label text-muted small fw-bold">QUẬN / HUYỆN</label>
                                        <input type="text" className="form-control" name="district"
                                               value={formData.district} onChange={handleInputChange} disabled={!isEditing} />
                                    </div>
                                    <div className="col-md-5 mt-3 mt-md-0">
                                        <label className="form-label text-muted small fw-bold">TÊN ĐƯỜNG</label>
                                        <input type="text" className="form-control" name="street"
                                               value={formData.street} onChange={handleInputChange} disabled={!isEditing} />
                                    </div>
                                    <div className="col-md-3 mt-3 mt-md-0">
                                        <label className="form-label text-muted small fw-bold">SỐ NHÀ</label>
                                        <input type="text" className="form-control" name="houseNumber"
                                               value={formData.houseNumber} onChange={handleInputChange} disabled={!isEditing} />
                                    </div>
                                </div>

                                {/* Ảnh đại diện */}
                                {isEditing && (
                                    <div className="mb-4">
                                        <label className="form-label text-muted small fw-bold">ẢNH ĐẠI DIỆN MỚI</label>
                                        <input
                                            type="file"
                                            className="form-control"
                                            accept="image/png, image/jpeg, image/jpg"
                                            onChange={handleAvatarUpload}
                                        />
                                        <small className="text-muted mt-1 d-block">Định dạng: JPG, PNG, JPEG. Khuyên dùng ảnh vuông.</small>
                                    </div>
                                )}

                                {/* Nút bấm */}
                                <div className="d-flex justify-content-end gap-2 mt-4">
                                    {isEditing ? (
                                        <>
                                            <button
                                                type="button"
                                                className="btn btn-light"
                                                onClick={() => {
                                                    setIsEditing(false);
                                                    setMessage({ type: '', text: '' });
                                                }}
                                            >
                                                Hủy
                                            </button>
                                            <button type="submit" className="btn btn-primary-custom px-4">
                                                Lưu thay đổi
                                            </button>
                                        </>
                                    ) : (
                                        <button
                                            type="button"
                                            className="btn btn-outline-primary-custom px-4"
                                            onClick={() => setIsEditing(true)}
                                        >
                                            Chỉnh sửa hồ sơ
                                        </button>
                                    )}
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default ProfilePage;