package com.ecommerce.product.service;

import com.ecommerce.product.dto.request.SellerProductRequest;
import com.ecommerce.product.dto.response.*;

import java.util.List;
public interface SellerProductService {

    List<SellerProductResponse>
    getMyProducts(Long sellerId);

    SellerProductResponse createProduct(
            Long sellerId,
            SellerProductRequest request);

    SellerProductResponse updateProduct(
            Long sellerId,
            Long sellerProductId,
            SellerProductRequest request);

    void changeStatus(
            Long sellerId,
            Long sellerProductId,
            boolean active);

    void deleteProduct(
            Long sellerId,
            Long sellerProductId);
}