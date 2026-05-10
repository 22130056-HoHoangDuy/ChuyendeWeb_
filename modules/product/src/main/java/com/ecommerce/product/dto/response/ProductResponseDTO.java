package com.ecommerce.product.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ProductResponseDTO {
    private Long sellerProductId;
    private String productName;
    private Double price;
    private String avatar;
    private Double averageRating;
    private boolean isFavorite;
}