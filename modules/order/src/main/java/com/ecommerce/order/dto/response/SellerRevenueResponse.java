package com.ecommerce.order.dto.response;

public record SellerRevenueResponse(

        Double revenue,

        Integer totalOrders,

        Integer totalProductsSold
) {
}