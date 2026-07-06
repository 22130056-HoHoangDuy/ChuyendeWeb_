package com.ecommerce.order.service.impl;

import com.ecommerce.order.domain.Order;
import com.ecommerce.order.domain.OrderItem;
import com.ecommerce.order.dto.response.SellerOrderResponse;
import com.ecommerce.order.dto.response.SellerRevenueResponse;
import com.ecommerce.order.dto.response.TopSellingProductResponse;
import com.ecommerce.order.enums.OrderStatus;
import com.ecommerce.order.repository.OrderItemRepository;
import com.ecommerce.order.repository.OrderRepository;
import com.ecommerce.order.service.SellerOrderService;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class SellerOrderServiceImpl
        implements SellerOrderService {

    private final OrderRepository orderRepository;
    private final OrderItemRepository orderItemRepository;

    @Override
    public List<SellerOrderResponse> getOrders(Long sellerId) {

        return orderRepository
                .findAllBySellerId(sellerId)
                .stream()
                .map(order ->
                        new SellerOrderResponse(
                                order.getId(),
                                order.getUserId(),
                                order.getTotalPrice(),
                                order.getShippingAddress(),
                                order.getOrderStatus(),
                                order.getCreatedAt()
                        ))
                .toList();
    }

    @Override
    @Transactional
    public void updateOrderStatus(
            Long sellerId,
            Long orderId,
            OrderStatus status) {

        Order order =
                orderRepository
                        .findById(orderId)
                        .orElseThrow(
                                () -> new RuntimeException(
                                        "Không tìm thấy đơn hàng"));

        if (!order.getSellerId().equals(sellerId)) {
            throw new RuntimeException(
                    "Bạn không có quyền");
        }

        order.setOrderStatus(status);

        orderRepository.save(order);
    }

    @Override
    public SellerRevenueResponse
    getRevenue(Long sellerId) {

        List<Order> orders =
                orderRepository
                        .findAllBySellerId(
                                sellerId);

        double revenue =
                orders.stream()
                        .filter(
                                o ->
                                        o.getOrderStatus()
                                                == OrderStatus.DELIVERED)
                        .mapToDouble(
                                Order::getTotalPrice)
                        .sum();

        int totalOrders =
                orders.size();

        List<OrderItem> items =
                orders.stream()
                        .flatMap(
                                o ->
                                        orderItemRepository
                                                .findByOrderId(
                                                        o.getId())
                                                .stream())
                        .toList();

        int sold =
                items.stream()
                        .mapToInt(
                                OrderItem::getQuantity)
                        .sum();

        return new SellerRevenueResponse(
                revenue,
                totalOrders,
                sold
        );
    }

    @Override
    public List<TopSellingProductResponse>
    getTopSelling(Long sellerId) {

        List<Order> orders =
                orderRepository
                        .findAllBySellerId(
                                sellerId);

        List<OrderItem> items =
                orders.stream()
                        .flatMap(
                                o ->
                                        orderItemRepository
                                                .findByOrderId(
                                                        o.getId())
                                                .stream())
                        .toList();

        Map<Long, Integer> soldMap =
                new HashMap<>();

        Map<Long, Double> revenueMap =
                new HashMap<>();

        for (OrderItem item : items) {

            soldMap.merge(
                    item.getSellerProductId(),
                    item.getQuantity(),
                    Integer::sum);

            revenueMap.merge(
                    item.getSellerProductId(),
                    item.getPrice()
                            * item.getQuantity(),
                    Double::sum);
        }

        return soldMap.entrySet()
                .stream()
                .sorted(
                        Map.Entry
                                .<Long, Integer>comparingByValue()
                                .reversed())
                .map(
                        e ->
                                new TopSellingProductResponse(
                                        e.getKey(),
                                        e.getValue(),
                                        revenueMap.get(
                                                e.getKey())
                                ))
                .toList();
    }
}