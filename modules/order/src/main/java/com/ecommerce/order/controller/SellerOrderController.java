package com.ecommerce.order.controller;

import com.ecommerce.common.security.CurrentUserProvider;
import com.ecommerce.order.enums.OrderStatus;
import com.ecommerce.order.service.SellerOrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/seller")
@RequiredArgsConstructor
public class SellerOrderController {

    private final SellerOrderService service;
    private final CurrentUserProvider currentUserProvider;

    @GetMapping("/orders")
    public ResponseEntity<?> getOrders() {

        return ResponseEntity.ok(
                service.getOrders(
                        currentUserProvider
                                .getCurrentUserId()));
    }

    @PatchMapping("/orders/{orderId}")
    public ResponseEntity<?> updateStatus(
            @PathVariable Long orderId,
            @RequestParam OrderStatus status) {

        service.updateOrderStatus(
                currentUserProvider
                        .getCurrentUserId(),
                orderId,
                status);

        return ResponseEntity.ok(
                "Cập nhật thành công");
    }

    @GetMapping("/revenue")
    public ResponseEntity<?> revenue() {

        return ResponseEntity.ok(
                service.getRevenue(
                        currentUserProvider
                                .getCurrentUserId()));
    }

    @GetMapping("/top-selling")
    public ResponseEntity<?> topSelling() {

        return ResponseEntity.ok(
                service.getTopSelling(
                        currentUserProvider
                                .getCurrentUserId()));
    }
}