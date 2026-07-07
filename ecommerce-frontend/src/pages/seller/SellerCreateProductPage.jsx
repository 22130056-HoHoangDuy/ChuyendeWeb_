import React, {useState} from 'react';
import {useNavigate} from 'react-router-dom';

const SellerCreateProductPage = () => {
    const navigate = useNavigate();
    const [product, setProduct] = useState({
        name: '',
        category: '',
        price: '',
        stock: '',
        sku: '',
        image: ''
    });

    const handleChange = (e) => {
        const {name, value} = e.target;
        setProduct({...product, [name]: value});
    };

    const handleSubmit = (e) => {
        e.preventDefault();
        // Mai có API chỉ cần gọi: sellerService.createProduct(product)...
        alert(`Đã gửi yêu cầu thêm sản phẩm: ${product.name}`);
        navigate('/seller/products');
    };

    return (
        <div style={{maxWidth: '800px'}}>
            <div className="d-flex justify-content-between align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 className="h2 text-success">➕ Thêm sản phẩm decor mới</h1>
                <button className="btn btn-outline-secondary" onClick={() => navigate('/seller/products')}>
                    Quay lại
                </button>
            </div>

            <div className="card shadow-sm p-4">
                <form onSubmit={handleSubmit}>
                    <div className="mb-3">
                        <label className="form-label fw-bold">Tên sản phẩm</label>
                        <input type="text" className="form-control" name="name" required
                               placeholder="Ví dụ: Đèn ngủ đám mây cho bé" onChange={handleChange}/>
                    </div>

                    <div className="row">
                        <div className="col-md-6 mb-3">
                            <label className="form-label fw-bold">Danh mục sản phẩm</label>
                            <select className="form-select" name="category" required onChange={handleChange}>
                                <option value="">-- Chọn danh mục --</option>
                                <option value="1">Đèn ngủ phòng ngủ</option>
                                <option value="2">Thảm trải sàn trẻ em</option>
                                <option value="3">Decal dán tường bé trai/bé gái</option>
                            </select>
                        </div>
                        <div className="col-md-6 mb-3">
                            <label className="form-label fw-bold">Mã sản phẩm (SKU)</label>
                            <input type="text" className="form-control" name="sku" placeholder="Ví dụ: DEN-MAY-01"
                                   onChange={handleChange}/>
                        </div>
                    </div>

                    <div className="row">
                        <div className="col-md-6 mb-3">
                            <label className="form-label fw-bold">Giá bán (đ)</label>
                            <input type="number" className="form-control" name="price" required
                                   placeholder="Nhập giá bán" onChange={handleChange}/>
                        </div>
                        <div className="col-md-6 mb-3">
                            <label className="form-label fw-bold">Số lượng nhập kho</label>
                            <input type="number" className="form-control" name="stock" required
                                   placeholder="Nhập số lượng tồn kho" onChange={handleChange}/>
                        </div>
                    </div>

                    <div className="mb-3">
                        <label className="form-label fw-bold">Đường dẫn ảnh sản phẩm (URL)</label>
                        <input type="text" className="form-control" name="image"
                               placeholder="Nhập link ảnh sản phẩm từ Unsplash hoặc Internet" onChange={handleChange}/>
                    </div>

                    <button type="submit" className="btn btn-success px-4 py-2 fw-bold mt-2">
                        Thêm sản phẩm
                    </button>
                </form>
            </div>
        </div>
    );
};

export default SellerCreateProductPage;