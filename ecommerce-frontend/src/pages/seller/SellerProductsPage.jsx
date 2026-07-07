import React, {useEffect, useState} from 'react';
import {useNavigate} from 'react-router-dom';
import {sellerService} from '../../services/sellerService';

const SellerProductsPage = () => {
    const navigate = useNavigate();
    const [products, setProducts] = useState([]);
    const [loading, setLoading] = useState(true);

    // 1. Gọi API lấy danh sách sản phẩm khi trang được load
    useEffect(() => {
        loadProducts();
    }, []);

    const loadProducts = () => {
        setLoading(true);
        sellerService.getProducts()
            .then(data => {
                setProducts(data);
                setLoading(false);
            })
            .catch(err => {
                console.error("Lỗi khi lấy danh sách sản phẩm:", err);
                setLoading(false);
            });
    };

    // 2. Hàm xử lý Xóa sản phẩm
    const handleDelete = (id) => {
        if (window.confirm("Anh có chắc chắn muốn xóa sản phẩm decor này không?")) {
            // Giả sử anh có API delete, nếu chưa có trong service anh có thể bổ sung sau nha
            // Ở đây em làm mẫu luồng gọi hoặc thông báo:
            alert(`Đã kích hoạt yêu cầu xóa sản phẩm số: ${id}`);
            // Sau khi xóa thành công thì gọi lại loadProducts() để cập nhật bảng
        }
    };

    // 3. Hàm xử lý Bật/Tắt trạng thái hoạt động (Enable/Disable)
    const handleToggleStatus = (id, currentStatus) => {
        const nextStatus = currentStatus === 'ACTIVE' ? 'INACTIVE' : 'ACTIVE';
        alert(`Chuyển trạng thái sản phẩm ${id} sang: ${nextStatus}`);
        // Chỗ này sau này anh sẽ gọi API cập nhật trạng thái của anh nhé
    };

    if (loading) return <div className="text-center my-5"><h4>Đang tải danh sách sản phẩm phòng bé...</h4></div>;

    return (
        <div>
            {/* Tiêu đề & Nút Thêm nhanh */}
            <div className="d-flex justify-content-between align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 className="h2 text-primary">📦 Quản lý sản phẩm của tôi</h1>
                <button
                    className="btn btn-success fw-bold"
                    onClick={() => navigate('/seller/products/create')}
                >
                    ➕ Thêm sản phẩm mới
                </button>
            </div>

            {/* Bảng danh sách sản phẩm */}
            <div className="card shadow-sm">
                <div className="card-body p-0">
                    <div className="table-responsive">
                        <table className="table table-hover table-striped align-middle mb-0">
                            <thead className="table-dark">
                            <tr>
                                <th scope="col" style={{width: '80px'}}>Ảnh</th>
                                <th scope="col">Tên sản phẩm</th>
                                <th scope="col">Giá bán</th>
                                <th scope="col">Kho hàng</th>
                                <th scope="col">SKU</th>
                                <th scope="col">Đánh giá</th>
                                <th scope="col">Trạng thái</th>
                                <th scope="col" className="text-center" style={{width: '220px'}}>Hành động</th>
                            </tr>
                            </thead>
                            <tbody>
                            {products.length === 0 ? (
                                <tr>
                                    <td colSpan="8" className="text-center py-4 text-muted">
                                        Shop chưa có sản phẩm nào. Anh bấm "Thêm sản phẩm mới" để bắt đầu nhé!
                                    </td>
                                </tr>
                            ) : (
                                products.map((product) => (
                                    <tr key={product.id || product.sellerProductId}>
                                        {/* Ảnh sản phẩm */}
                                        <td>
                                            <img
                                                src={product.image || "https://via.placeholder.com/60"}
                                                alt={product.name}
                                                className="img-thumbnail"
                                                style={{width: '60px', height: '60px', objectFit: 'cover'}}
                                            />
                                        </td>
                                        {/* Tên sản phẩm */}
                                        <td>
                                            <span className="fw-bold text-dark">{product.name}</span>
                                        </td>
                                        {/* Giá */}
                                        <td className="text-danger fw-bold">
                                            {product.price?.toLocaleString('vi-VN')} đ
                                        </td>
                                        {/* Tồn kho */}
                                        <td>
                                                <span
                                                    className={`badge ${product.stock > 10 ? 'bg-info' : 'bg-danger'}`}>
                                                    {product.stock} chiếc
                                                </span>
                                        </td>
                                        {/* SKU */}
                                        <td><code className="text-secondary">{product.sku || 'N/A'}</code></td>
                                        {/* Rating */}
                                        <td className="text-warning fw-bold">⭐ {product.rating || '0.0'}</td>
                                        {/* Trạng thái */}
                                        <td>
                                                <span
                                                    className={`badge ${product.status === 'ACTIVE' ? 'bg-success' : 'bg-secondary'}`}>
                                                    {product.status === 'ACTIVE' ? 'Đang hiện' : 'Đang ẩn'}
                                                </span>
                                        </td>
                                        {/* Hành động */}
                                        <td>
                                            <div className="d-flex justify-content-center gap-1">
                                                {/* Nút Sửa */}
                                                <button
                                                    className="btn btn-sm btn-outline-primary"
                                                    onClick={() => navigate(`/seller/products/edit/${product.id || product.sellerProductId}`)}
                                                >
                                                    Sửa
                                                </button>

                                                {/* Nút Ẩn/Hiện nhanh */}
                                                <button
                                                    className={`btn btn-sm ${product.status === 'ACTIVE' ? 'btn-outline-warning' : 'btn-outline-success'}`}
                                                    onClick={() => handleToggleStatus(product.id || product.sellerProductId, product.status)}
                                                >
                                                    {product.status === 'ACTIVE' ? 'Ẩn' : 'Hiện'}
                                                </button>

                                                {/* Nút Xóa */}
                                                <button
                                                    className="btn btn-sm btn-outline-danger"
                                                    onClick={() => handleDelete(product.id || product.sellerProductId)}
                                                >
                                                    Xóa
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                ))
                            )}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default SellerProductsPage;