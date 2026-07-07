import React, { useEffect, useState } from 'react';
import { sellerService } from '../../services/sellerService';

const SellerDashboardPage = () => {
    const [data, setData] = useState({
        revenue: 0,
        totalProducts: 0,
        totalOrders: 0,
        totalSold: 0,
        avgRating: 0
    });
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        sellerService.getDashboard()
            .then(res => {
                setData(res);
                setLoading(false);
            })
            .catch(err => {
                console.error("Lỗi lấy dữ liệu Dashboard:", err);
                setLoading(false);
            });
    }, []);

    if (loading) return <div className="text-center my-5"><h4>Đang tải dữ liệu cửa hàng...</h4></div>;

    return (
        <div>
            <div className="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 className="h2 text-primary">Bảng điều khiển của Shop</h1>
            </div>

            {/* GRID CÁC THẺ CARD THỐNG KÊ */}
            <div className="row g-4">
                {/* Doanh thu */}
                <div className="col-12 col-sm-6 col-xl-3">
                    <div className="card border-start border-primary border-4 shadow-sm h-100 py-2">
                        <div className="card-body">
                            <div className="text-xs font-weight-bold text-primary text-uppercase mb-1">Doanh thu tổng</div>
                            <div className="h5 mb-0 font-weight-bold text-gray-800">
                                {data.revenue?.toLocaleString('vi-VN')} đ
                            </div>
                        </div>
                    </div>
                </div>

                {/* Sản phẩm */}
                <div className="col-12 col-sm-6 col-xl-3">
                    <div className="card border-start border-success border-4 shadow-sm h-100 py-2">
                        <div className="card-body">
                            <div className="text-xs font-weight-bold text-success text-uppercase mb-1">Tổng sản phẩm</div>
                            <div className="h5 mb-0 font-weight-bold text-gray-800">{data.totalProducts} sản phẩm</div>
                        </div>
                    </div>
                </div>

                {/* Đơn hàng */}
                <div className="col-12 col-sm-6 col-xl-3">
                    <div className="card border-start border-info border-4 shadow-sm h-100 py-2">
                        <div className="card-body">
                            <div className="text-xs font-weight-bold text-info text-uppercase mb-1">Tổng đơn hàng</div>
                            <div className="h5 mb-0 font-weight-bold text-gray-800">{data.totalOrders} đơn</div>
                        </div>
                    </div>
                </div>

                {/* Đã bán */}
                <div className="col-12 col-sm-6 col-xl-3">
                    <div className="card border-start border-warning border-4 shadow-sm h-100 py-2">
                        <div className="card-body">
                            <div className="text-xs font-weight-bold text-warning text-uppercase mb-1">Đã bán ra</div>
                            <div className="h5 mb-0 font-weight-bold text-gray-800">{data.totalSold} mặt hàng</div>
                        </div>
                    </div>
                </div>
            </div>

            {/* RATING CARD */}
            <div className="row mt-4">
                <div className="col-12 col-md-4">
                    <div className="card bg-light text-center p-3 shadow-sm">
                        <h5 className="card-title text-muted">⭐ Đánh giá cửa hàng trung bình</h5>
                        <h2 className="text-warning font-weight-bold mt-2">{data.avgRating || 0} / 5</h2>
                        <p className="text-xs text-secondary mb-0">Dựa trên các đánh giá từ người mua phòng bé</p>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default SellerDashboardPage;