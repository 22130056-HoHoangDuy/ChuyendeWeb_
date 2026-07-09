package com.ecommerce.order.controller;

import com.ecommerce.common.security.CurrentUserProvider;
import com.ecommerce.order.dto.request.OrderRequest;
import com.ecommerce.order.service.OrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/orders")
@RequiredArgsConstructor
public class OrderController {

    private final CurrentUserProvider currentUserProvider;
    private final OrderService orderService;

    @PostMapping("/buy-now")
    public ResponseEntity<?> buyNow(@RequestBody OrderRequest request) {

        Long buyerId = currentUserProvider.getCurrentUserId();

        return ResponseEntity.ok(
                orderService.createOrder(
                        request,
                        buyerId
                )
        );
    }

    @PostMapping("/checkout")
    public ResponseEntity<?> checkout(
            @RequestParam String address
    ) {

        Long buyerId = currentUserProvider.getCurrentUserId();

        return ResponseEntity.ok(
                orderService.checkout(
                        buyerId,
                        address
                )
        );
    }

    @PatchMapping("/cart/update")
    public ResponseEntity<?> updateCartQuantity(
            @RequestParam Long sellerProductId,
            @RequestParam int delta
    ) {

        Long buyerId = currentUserProvider.getCurrentUserId();

        orderService.updateCartItemQuantity(
                buyerId,
                sellerProductId,
                delta
        );

        return ResponseEntity.ok("Cập nhật giỏ hàng thành công");
    }

    @GetMapping("/detail/{id}")
    public ResponseEntity<?> getOrder(
            @PathVariable Long id
    ) {
        return ResponseEntity.ok(
                orderService.getOrderById(id)
        );
    }
}