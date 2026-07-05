package com.ecommerce.product.dto.response;

import com.ecommerce.product.enums.SellerProductStatus;

public record SellerProductResponse(

        Long sellerProductId,

        Long productId,

        String productName,

        String image,

        Double price,

        Integer stock,

        String sku,

        SellerProductStatus status,

        Double averageRating
) {
}