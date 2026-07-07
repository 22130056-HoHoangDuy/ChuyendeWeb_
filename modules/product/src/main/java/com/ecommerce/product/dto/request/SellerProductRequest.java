package com.ecommerce.product.dto.request;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SellerProductRequest {

    // Product trong catalog chung
    private Long productId;

    // Thông tin seller quản lý
    private Double price;

    private Integer stock;

    private String sku;
}