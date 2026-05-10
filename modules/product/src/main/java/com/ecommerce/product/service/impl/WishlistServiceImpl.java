package com.ecommerce.product.service.impl;

import com.ecommerce.product.domain.Wishlist;
import com.ecommerce.product.repository.WishlistRepository;
import com.ecommerce.product.service.WishlistService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class WishlistServiceImpl implements WishlistService {

    private final WishlistRepository wishlistRepository;

    @Override
    @Transactional
    public void toggleWishlist(Long userId, Long sellerProductId) {
        if (wishlistRepository.existsByUserIdAndSellerProductId(userId, sellerProductId)) {
            wishlistRepository.deleteByUserIdAndSellerProductId(userId, sellerProductId);
        } else {
            Wishlist wishlist = Wishlist.builder()
                    .userId(userId)
                    .sellerProductId(sellerProductId)
                    .createdAt(LocalDateTime.now())
                    .build();
            wishlistRepository.save(wishlist);
        }
    }

    @Override
    public List<Wishlist> getMyWishlist(Long userId) {
        return wishlistRepository.findAllByUserId(userId);
    }

    @Override
    public Set<Long> getFavoriteSellerProductIds(Long userId) {
        if (userId == null) return Collections.emptySet();

        return wishlistRepository.findAllByUserId(userId)
                .stream()
                .map(Wishlist::getSellerProductId)
                .collect(Collectors.toSet());
    }

    @Override
    public boolean isFavorite(Long userId, Long sellerProductId) {
        if (userId == null) return false;
        return wishlistRepository.existsByUserIdAndSellerProductId(userId, sellerProductId);
    }
}