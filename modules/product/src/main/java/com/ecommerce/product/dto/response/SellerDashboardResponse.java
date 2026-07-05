package com.ecommerce.product.dto.response;

public record SellerDashboardResponse(

        Double totalRevenue,

        Integer totalProducts,

        Integer totalOrders,

        Integer totalSold,

        Double averageRating
) {
}