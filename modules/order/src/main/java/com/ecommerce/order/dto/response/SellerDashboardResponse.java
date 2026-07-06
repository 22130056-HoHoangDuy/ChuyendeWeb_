package com.ecommerce.order.dto.response;

public record SellerDashboardResponse(

        Double totalRevenue,

        Integer totalOrders,

        Integer totalProducts,

        Integer totalSold,

        Double averageRating
) {
}