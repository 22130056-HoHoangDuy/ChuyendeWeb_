import React, { useEffect, useState } from 'react';
import { sellerService } from '../../services/sellerService';

const SellerRevenuePage = () => {
    const [revenueData, setRevenueData] = useState({ revenue: 0, totalOrders: 0, totalProductsSold: 0 });
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        // Mai kết nối DB: sellerService.getRevenue().then(res => setRevenueData(res))
        // Dữ liệu giả lập khớp response mẫu của anh
        setRevenueData({ revenue: 12500000, totalOrders: 120, totalProductsSold: 856 });
        setLoading(false);
    }, []);

    if (loading) return <div className="text-center my-5"><h4>Đang tổng hợp báo cáo tài chính...</h4></div>;

    return (
        <div>
            <div className="pt-3 pb-2 mb-3 border-bottom">
                <h1 className="h2 text-primary">💰 Thống kê doanh thu cửa hàng</h1>
            </div>

            <div className="row g-4 text-center">
                <div className="col-md-4">
                    <div className="card bg-success text-white p-4 shadow-sm h-100 d-flex flex-column justify-content-center">
                        <h4 className="card-title text-white-50">Tổng doanh thu thực nhận</h4>
                        <h2 className="display-6 fw-bold mt-2">{revenueData.revenue?.toLocaleString('vi-VN')} đ</h2>
                    </div>
                </div>
                <div className="col-md-4">
                    <div className="card bg-info text-white p-4 shadow-sm h-100 d-flex flex-column justify-content-center">
                        <h4 className="card-title text-white-50">Tổng đơn hàng hoàn thành</h4>
                        <h2 className="display-6 fw-bold mt-2">{revenueData.totalOrders} Đơn</h2>
                    </div>
                </div>
                <div className="col-md-4">
                    <div className="card bg-secondary text-white p-4 shadow-sm h-100 d-flex flex-column justify-content-center">
                        <h4 className="card-title text-white-50">Số sản phẩm đã trao tay khách</h4>
                        <h2 className="display-6 fw-bold mt-2">{revenueData.totalProductsSold} Sản phẩm</h2>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default SellerRevenuePage;