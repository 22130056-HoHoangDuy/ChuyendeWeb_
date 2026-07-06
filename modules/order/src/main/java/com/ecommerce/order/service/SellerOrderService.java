package com.ecommerce.order.service;

import com.ecommerce.order.dto.response.SellerOrderResponse;
import com.ecommerce.order.dto.response.SellerRevenueResponse;
import com.ecommerce.order.dto.response.TopSellingProductResponse;
import com.ecommerce.order.enums.OrderStatus;

import java.util.List;

public interface SellerOrderService {

    List<SellerOrderResponse>
    getOrders(Long sellerId);

    void updateOrderStatus(
            Long sellerId,
            Long orderId,
            OrderStatus status);

    SellerRevenueResponse
    getRevenue(Long sellerId);

    List<TopSellingProductResponse>
    getTopSelling(Long sellerId);
}