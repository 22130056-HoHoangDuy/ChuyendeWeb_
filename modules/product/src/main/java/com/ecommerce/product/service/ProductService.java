package com.ecommerce.product.service;

import com.ecommerce.product.domain.Product;
import com.ecommerce.product.domain.SellerProduct;
import com.ecommerce.product.dto.request.ProductFilterRequest;
import com.ecommerce.product.dto.request.ProductRequest;
import com.ecommerce.product.dto.response.ProductDetailResponse;
import com.ecommerce.product.dto.response.ProductHomeResponse;
import org.springframework.data.domain.Page;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface ProductService {
    Product createProduct(ProductRequest request);

    List<Product> getAll();

    Product getById(Long id);

    @Transactional
    Product updateProduct(Long id, ProductRequest request);

    @Transactional
    void deleteProduct(Long id);

    List<ProductHomeResponse> getAllActiveForHomePage(Long userId);

    List<Product> searchSemantic(List<Double> queryVector);

    SellerProduct getSellerProductById(Long id);

    void changeSellerProductStatus(Long sellerProductId, boolean active);


    List<SellerProduct> getAllActiveBySeller(Long sellerId);

    List<SellerProduct> getAllForAdmin();

    ProductDetailResponse getProductDetail(Long id);

    Page<ProductHomeResponse> filterProducts(
            ProductFilterRequest request,
            Long userId);
}