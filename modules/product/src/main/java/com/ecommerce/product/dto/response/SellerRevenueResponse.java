package com.ecommerce.product.dto.response;

public record SellerRevenueResponse(

        Integer month,

        Integer year,

        Double revenue,

        Integer totalOrders
) {
}