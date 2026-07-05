package com.ecommerce.product.dto.request;

import lombok.Data;

@Data
public class ProductFilterRequest {

    private String keyword;

    private Long categoryId;

    private String origin;

    private String size;

    // giữ lại nhưng chưa implement
    private Double minPrice;
    private Double maxPrice;

    private Boolean inStock;

    private String sortBy = "newest";

    private Integer page = 0;

    private Integer sizePage = 12;
}
