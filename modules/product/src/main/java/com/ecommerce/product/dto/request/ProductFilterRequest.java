package com.ecommerce.product.dto.request;

import lombok.Data;

@Data
public class ProductFilterRequest {

    // Product
    private String keyword;
    private Long categoryId;
    private String origin;
    private String size;

    // SellerProduct
    private Double minPrice;
    private Double maxPrice;
    private Boolean inStock;

    // UI
    private String sortBy;

    // paging
    private Integer page = 0;
    private Integer sizePage = 12;

}
