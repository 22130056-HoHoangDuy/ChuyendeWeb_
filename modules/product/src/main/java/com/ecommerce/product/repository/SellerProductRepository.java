package com.ecommerce.product.repository;

import com.ecommerce.product.domain.SellerProduct;
import com.ecommerce.product.enums.SellerProductStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SellerProductRepository
        extends JpaRepository<SellerProduct, Long> {

    List<SellerProduct>
    findAllByStatus(
            SellerProductStatus status);

    List<SellerProduct>
    findAllBySellerIdAndStatus(
            Long sellerId,
            SellerProductStatus status);

    List<SellerProduct>
    findAllBySellerId(
            Long sellerId);

    // dùng cho filter/home page
    List<SellerProduct>
    findAllByProductIdInAndStatus(
            List<Long> productIds,
            SellerProductStatus status);
}