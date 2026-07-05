package com.ecommerce.product.service;

import com.ecommerce.product.dto.response.SellerDashboardResponse;
import com.ecommerce.product.dto.response.SellerProductResponse;

import java.util.List;

public interface SellerProductService {

    List<SellerProductResponse>
    getMyProducts(Long sellerId);

    SellerDashboardResponse
    getDashboard(Long sellerId);

}