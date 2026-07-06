package com.ecommerce.product.dto.response;

public record TopSellingProductResponse(

        Long sellerProductId,

        String productName,

        Integer soldQuantity,

        Double revenue
) {
}