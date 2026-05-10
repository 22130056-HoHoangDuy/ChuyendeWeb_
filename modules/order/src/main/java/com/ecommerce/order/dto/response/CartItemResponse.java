package com.ecommerce.order.dto.response;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class CartItemResponse {
    private Long id;
    private Long sellerProductId;
    private Integer quantity;
    private String productName;
    private Double price;
    private String imageUrl;
}