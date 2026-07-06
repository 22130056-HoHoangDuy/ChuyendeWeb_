package com.ecommerce.order.service;

import com.ecommerce.order.dto.response.SellerDashboardResponse;

public interface SellerDashboardService {

    SellerDashboardResponse
    getDashboard(Long sellerId);
}