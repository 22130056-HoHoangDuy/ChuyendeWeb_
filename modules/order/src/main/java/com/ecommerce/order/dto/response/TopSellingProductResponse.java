package com.ecommerce.order.dto.response;

public record TopSellingProductResponse(

        Long sellerProductId,

        Integer soldQuantity,

        Double revenue
) {
}