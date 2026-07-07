package com.ecommerce.product.dto.response;

import java.time.LocalDateTime;

public record SellerOrderResponse(

        Long orderId,

        Long orderItemId,

        Long productId,

        String productName,

        Integer quantity,

        Double price,

        Double total,

        String orderStatus,

        LocalDateTime createdAt
) {
}