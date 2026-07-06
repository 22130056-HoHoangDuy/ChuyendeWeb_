package com.ecommerce.order.dto.response;

import com.ecommerce.order.enums.OrderStatus;

import java.time.LocalDateTime;

public record SellerOrderResponse(

        Long orderId,

        Long customerId,

        Double totalPrice,

        String shippingAddress,

        OrderStatus status,

        LocalDateTime createdAt
) {
}