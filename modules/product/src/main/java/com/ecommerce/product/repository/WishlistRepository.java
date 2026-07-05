package com.ecommerce.product.repository;

import com.ecommerce.product.domain.Wishlist;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface WishlistRepository
        extends JpaRepository<Wishlist, Long> {

    void deleteByUserIdAndSellerProductId(
            Long userId,
            Long sellerProductId);

    List<Wishlist> findAllByUserId(
            Long userId);

    boolean existsByUserIdAndSellerProductId(
            Long userId,
            Long sellerProductId);

    List<Wishlist>
    findAllByUserIdAndSellerProductIdIn(
            Long userId,
            List<Long> sellerProductIds);
}