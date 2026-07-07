package com.ecommerce.order.service.impl;

import com.ecommerce.order.domain.Order;
import com.ecommerce.order.domain.OrderItem;
import com.ecommerce.order.dto.response.SellerDashboardResponse;
import com.ecommerce.order.enums.OrderStatus;
import com.ecommerce.order.repository.OrderItemRepository;
import com.ecommerce.order.repository.OrderRepository;
import com.ecommerce.order.service.SellerDashboardService;
import com.ecommerce.product.domain.SellerProduct;
import com.ecommerce.product.repository.ReviewRepository;
import com.ecommerce.product.repository.SellerProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;


import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class SellerDashboardServiceImpl
        implements SellerDashboardService {

    private final OrderRepository orderRepository;
    private final OrderItemRepository orderItemRepository;

    private final SellerProductRepository sellerProductRepository;
    private final ReviewRepository reviewRepository;

    @Override
    public SellerDashboardResponse
    getDashboard(Long sellerId) {

        List<SellerProduct> sellerProducts =
                sellerProductRepository
                        .findAllBySellerId(
                                sellerId);

        Integer totalProducts =
                sellerProducts.size();

        List<Long> productIds =
                sellerProducts.stream()
                        .map(
                                SellerProduct::getProductId)
                        .distinct()
                        .toList();

        Map<Long, Double> ratingMap =
                reviewRepository
                        .getAverageRatings(
                                productIds)
                        .stream()
                        .collect(
                                Collectors.toMap(
                                        r ->
                                                (Long) r[0],
                                        r ->
                                                ((Number) r[1])
                                                        .doubleValue()
                                ));

        Double averageRating =
                ratingMap.values()
                        .stream()
                        .mapToDouble(
                                Double::doubleValue)
                        .average()
                        .orElse(0.0);

        List<Order> orders =
                orderRepository
                        .findAllBySellerId(
                                sellerId);

        Integer totalOrders =
                orders.size();

        Double totalRevenue =
                orders.stream()
                        .filter(
                                o ->
                                        o.getOrderStatus()
                                                ==
                                                OrderStatus.DELIVERED)
                        .mapToDouble(
                                Order::getTotalPrice)
                        .sum();

        Integer totalSold =
                orders.stream()
                        .flatMap(
                                o ->
                                        orderItemRepository
                                                .findByOrderId(
                                                        o.getId())
                                                .stream())
                        .mapToInt(
                                OrderItem::getQuantity)
                        .sum();

        return new SellerDashboardResponse(
                totalRevenue,
                totalOrders,
                totalProducts,
                totalSold,
                averageRating
        );
    }
}