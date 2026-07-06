package com.ecommerce.product.service.impl;

import com.ecommerce.product.domain.Product;
import com.ecommerce.product.domain.SellerProduct;
import com.ecommerce.product.dto.request.SellerProductRequest;
import com.ecommerce.product.dto.response.SellerDashboardResponse;
import com.ecommerce.product.dto.response.SellerProductResponse;
import com.ecommerce.product.enums.SellerProductStatus;
import com.ecommerce.product.repository.ProductRepository;
import com.ecommerce.product.repository.ReviewRepository;
import com.ecommerce.product.repository.SellerProductRepository;
import com.ecommerce.product.service.SellerProductService;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class SellerProductServiceImpl
        implements SellerProductService {

    private final SellerProductRepository sellerProductRepository;
    private final ProductRepository productRepository;
    private final ReviewRepository reviewRepository;

    @Override
    public List<SellerProductResponse>
    getMyProducts(Long sellerId) {

        List<SellerProduct> products =
                sellerProductRepository
                        .findAllBySellerId(
                                sellerId);

        Map<Long, Product> productMap =
                productRepository
                        .findAllById(
                                products.stream()
                                        .map(
                                                SellerProduct::getProductId)
                                        .toList())
                        .stream()
                        .collect(
                                Collectors.toMap(
                                        Product::getId,
                                        p -> p
                                )
                        );

        Map<Long, Double> ratingMap =
                reviewRepository
                        .getAverageRatings(
                                productMap.keySet()
                                        .stream()
                                        .toList())
                        .stream()
                        .collect(
                                Collectors.toMap(
                                        row -> (Long) row[0],
                                        row -> ((Number) row[1])
                                                .doubleValue()
                                )
                        );

        return products.stream()
                .map(sp -> {

                    Product p =
                            productMap.get(
                                    sp.getProductId());

                    return new SellerProductResponse(
                            sp.getId(),
                            p.getId(),
                            p.getProductName(),
                            p.getAvatar(),
                            sp.getPrice(),
                            sp.getStock(),
                            sp.getSku(),
                            sp.getStatus(),
                            ratingMap.getOrDefault(
                                    p.getId(),
                                    0.0)
                    );
                })
                .toList();
    }

    @Override
    public SellerDashboardResponse
    getDashboard(Long sellerId) {

        List<SellerProduct> products =
                sellerProductRepository
                        .findAllBySellerId(
                                sellerId);

        Double revenue = 0.0;

        Integer totalProducts =
                products.size();

        Integer totalOrders = 0;

        Integer totalSold = 0;

        Double avgRating = 0.0;

        return new SellerDashboardResponse(
                revenue,
                totalProducts,
                totalOrders,
                totalSold,
                avgRating
        );
    }

    @Override
    public SellerProductResponse createProduct(Long sellerId, SellerProductRequest request) {
        return null;
    }

    @Override
    @Transactional
    public SellerProductResponse updateProduct(
            Long sellerId,
            Long sellerProductId,
            SellerProductRequest request
    ) {

        SellerProduct sellerProduct =
                sellerProductRepository
                        .findById(sellerProductId)
                        .orElseThrow(
                                () -> new RuntimeException(
                                        "Không tìm thấy sản phẩm"));

        if (!sellerProduct.getSellerId().equals(sellerId)) {
            throw new RuntimeException(
                    "Bạn không có quyền sửa sản phẩm này");
        }

        Product product =
                productRepository
                        .findById(
                                sellerProduct.getProductId())
                        .orElseThrow(
                                () -> new RuntimeException(
                                        "Không tìm thấy sản phẩm"));

        if (request.getPrice() != null)
            sellerProduct.setPrice(
                    request.getPrice());

        if (request.getStock() != null)
            sellerProduct.setStock(
                    request.getStock());

        if (request.getSku() != null)
            sellerProduct.setSku(
                    request.getSku());

        sellerProduct =
                sellerProductRepository
                        .save(sellerProduct);

        return new SellerProductResponse(
                sellerProduct.getId(),
                product.getId(),
                product.getProductName(),
                product.getAvatar(),
                sellerProduct.getPrice(),
                sellerProduct.getStock(),
                sellerProduct.getSku(),
                sellerProduct.getStatus(),
                0.0
        );
    }

    @Override
    @Transactional
    public void changeStatus(
            Long sellerId,
            Long sellerProductId,
            boolean active
    ) {

        SellerProduct sellerProduct =
                sellerProductRepository
                        .findById(sellerProductId)
                        .orElseThrow(
                                () -> new RuntimeException(
                                        "Không tìm thấy sản phẩm"));

        if (!sellerProduct.getSellerId().equals(sellerId)) {
            throw new RuntimeException(
                    "Bạn không có quyền");
        }

        sellerProduct.setStatus(
                active
                        ? SellerProductStatus.ACTIVE
                        : SellerProductStatus.INACTIVE);

        sellerProductRepository.save(
                sellerProduct);
    }

    @Override
    @Transactional
    public void deleteProduct(
            Long sellerId,
            Long sellerProductId
    ) {

        SellerProduct sellerProduct =
                sellerProductRepository
                        .findById(sellerProductId)
                        .orElseThrow(
                                () -> new RuntimeException(
                                        "Không tìm thấy sản phẩm"));

        if (!sellerProduct.getSellerId().equals(sellerId)) {
            throw new RuntimeException(
                    "Bạn không có quyền");
        }

        sellerProduct.setStatus(
                SellerProductStatus.INACTIVE);

        sellerProductRepository.save(
                sellerProduct);
    }
}