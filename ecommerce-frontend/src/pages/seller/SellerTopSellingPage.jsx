import React, { useEffect, useState } from 'react';
import { sellerService } from '../../services/sellerService';

const SellerTopSellingPage = () => {
    const [topProducts, setTopProducts] = useState([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        // Mai kết nối DB: sellerService.getTopSelling().then(res => setTopProducts(res))
        // Dữ liệu giả lập khớp response mẫu của anh
        setTopProducts([
            { sellerProductId: 1, name: "Đèn ngủ phi hành gia chiếu sao", soldQuantity: 150, revenue: 35000000 },
            { sellerProductId: 2, name: "Thảm trải sàn nỉ nhung hình gấu", soldQuantity: 95, revenue: 49400000 },
            { sellerProductId: 4, name: "Giấy dán tường bầu trời sao đêm", soldQuantity: 64, revenue: 5440000 }
        ]);
        setLoading(false);
    }, []);

    if (loading) return <div className="text-center my-5"><h4>Đang tính toán danh sách bán chạy...</h4></div>;

    return (
        <div>
            <div className="pt-3 pb-2 mb-3 border-bottom">
                <h1 className="h2 text-primary">⭐ Top sản phẩm bán chạy nhất</h1>
            </div>

            <div className="card shadow-sm">
                <div className="card-body p-0">
                    <div className="table-responsive">
                        <table className="table table-hover table-striped align-middle mb-0">
                            <thead className="table-dark">
                            <tr>
                                <th style={{ width: '120px' }}>Hạng bán chạy</th>
                                <th>Mã sản phẩm</th>
                                <th>Số lượng đã bán</th>
                                <th className="text-end pe-4">Tổng doanh thu đem về</th>
                            </tr>
                            </thead>
                            <tbody>
                            {topProducts.map((prod, index) => (
                                <tr key={prod.sellerProductId}>
                                    <td>
                                            <span className={`badge rounded-pill px-3 py-2 ${index === 0 ? 'bg-danger' : index === 1 ? 'bg-warning text-dark' : 'bg-info'}`}>
                                                Top {index + 1}
                                            </span>
                                    </td>
                                    <td>
                                        <strong>#{prod.sellerProductId}</strong>
                                    </td>
                                    <td>
                                        <span className="fw-bold text-success">{prod.soldQuantity}</span> sản phẩm
                                    </td>
                                    <td className="text-end fw-bold text-primary pe-4">
                                        {prod.revenue?.toLocaleString('vi-VN')} đ
                                    </td>
                                </tr>
                            ))}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default SellerTopSellingPage;