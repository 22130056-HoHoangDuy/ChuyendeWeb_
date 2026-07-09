package com.ecommerce.order.repository;

import com.ecommerce.order.domain.Order;
import com.ecommerce.order.enums.OrderStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {
    List<Order> findByUserId(Long userId);

    Order findAllByOrderStatus(OrderStatus status);

    List<Order> findAllBySellerId(
            Long sellerId);

    List<Order> findAllBySellerIdAndOrderStatus(
            Long sellerId,
            OrderStatus status);
}

