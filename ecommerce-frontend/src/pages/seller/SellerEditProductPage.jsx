import React, {useEffect, useState} from 'react';
import {useNavigate, useParams} from 'react-router-dom';

const SellerEditProductPage = () => {
    const {id} = useParams(); // Lấy ID sản phẩm từ URL thanh địa chỉ
    const navigate = useNavigate();
    const [loading, setLoading] = useState(true);

    const [product, setProduct] = useState({
        name: 'Đèn ngủ đám mây (Dữ liệu cũ)',
        category: 'Đèn ngủ phòng ngủ',
        price: 0,
        stock: 0,
        sku: '',
        image: ''
    });

    useEffect(() => {
        // Mai cắm DB: sellerService.getProductsById(id).then(res => { setProduct(res); setLoading(false); })
        // Tạm thời set loading giả lập để test giao diện sửa
        setTimeout(() => setLoading(false), 300);
    }, [id]);

    const handleChange = (e) => {
        const {name, value} = e.target;
        setProduct({...product, [name]: value});
    };

    const handleUpdate = (e) => {
        e.preventDefault();
        // Mai kết nối API PUT của anh: sellerService.editProduct(id, { price: product.price, stock: product.stock, sku: product.sku })
        alert(`Đã cập nhật sản phẩm mã số ${id} thành công!`);
        navigate('/seller/products');
    };

    if (loading) return <div className="text-center my-5"><h4>Đang tải thông tin sản phẩm...</h4></div>;

    return (
        <div style={{maxWidth: '800px'}}>
            <div className="d-flex justify-content-between align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 className="h2 text-warning">✏️ Chỉnh sửa sản phẩm #{id}</h1>
                <button className="btn btn-outline-secondary" onClick={() => navigate('/seller/products')}>
                    Quay lại
                </button>
            </div>

            <div className="card shadow-sm p-4 border-warning border-top border-4">
                <form onSubmit={handleUpdate}>
                    {/* Các trường không cho sửa (Disabled) */}
                    <div className="mb-3">
                        <label className="form-label text-muted">Tên sản phẩm (Không được phép sửa)</label>
                        <input type="text" className="form-control bg-light" value={product.name} disabled/>
                    </div>

                    {/* Các trường cho phép sửa theo quy định của Backend anh */}
                    <div className="mb-3">
                        <label className="form-label fw-bold text-primary">Mã sản phẩm (SKU)</label>
                        <input type="text" className="form-control" name="sku" value={product.sku}
                               onChange={handleChange} required/>
                    </div>

                    <div className="row">
                        <div className="col-md-6 mb-3">
                            <label className="form-label fw-bold text-primary">Giá bán mới (đ)</label>
                            <input type="number" className="form-control" name="price" value={product.price}
                                   onChange={handleChange} required/>
                        </div>
                        <div className="col-md-6 mb-3">
                            <label className="form-label fw-bold text-primary">Số lượng kho mới</label>
                            <input type="number" className="form-control" name="stock" value={product.stock}
                                   onChange={handleChange} required/>
                        </div>
                    </div>

                    <button type="submit" className="btn btn-warning px-4 py-2 fw-bold mt-2 text-dark">
                        Lưu thay đổi
                    </button>
                </form>
            </div>
        </div>
    );
};

export default SellerEditProductPage;