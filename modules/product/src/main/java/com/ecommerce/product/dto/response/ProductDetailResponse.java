package com.ecommerce.product.dto.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductDetailResponse {
    private Long id;              // ID của SellerProduct
    private String productName;   // Lấy từ bảng Product
    private String sku;           // Lấy từ bảng SellerProduct
    private Double price;
    private String avatar;        // Lấy từ bảng Product
    private String description;   // Lấy từ bảng Product
    private Integer stock;
    private Long sellerId;
}