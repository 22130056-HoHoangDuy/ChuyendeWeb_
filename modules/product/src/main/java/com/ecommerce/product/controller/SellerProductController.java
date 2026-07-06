package com.ecommerce.product.controller;

import com.ecommerce.product.dto.request.SellerProductRequest;
import com.ecommerce.product.service.SellerProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/seller")
@RequiredArgsConstructor
public class SellerProductController {

    private final SellerProductService
            sellerProductService;

    @GetMapping("/products")
    public ResponseEntity<?> getMyProducts(
            Authentication authentication
    ) {

        Long sellerId =
                Long.valueOf(
                        authentication.getName());

        return ResponseEntity.ok(
                sellerProductService
                        .getMyProducts(
                                sellerId));
    }

    @GetMapping("/dashboard")
    public ResponseEntity<?> dashboard(
            Authentication authentication
    ) {

        Long sellerId =
                Long.valueOf(
                        authentication.getName());

        return ResponseEntity.ok(
                sellerProductService
                        .getDashboard(
                                sellerId));
    }

    @PutMapping("/products/{id}")
    public ResponseEntity<?> updateProduct(
            Authentication authentication,
            @PathVariable Long id,
            @RequestBody SellerProductRequest request
    ) {

        Long sellerId =
                Long.valueOf(
                        authentication.getName());

        return ResponseEntity.ok(
                sellerProductService
                        .updateProduct(
                                sellerId,
                                id,
                                request));
    }

    @PatchMapping("/products/{id}/status")
    public ResponseEntity<?> changeStatus(
            Authentication authentication,
            @PathVariable Long id,
            @RequestParam boolean active
    ) {

        Long sellerId =
                Long.valueOf(
                        authentication.getName());

        sellerProductService
                .changeStatus(
                        sellerId,
                        id,
                        active);

        return ResponseEntity.ok(
                "Đã cập nhật trạng thái");
    }

    @DeleteMapping("/products/{id}")
    public ResponseEntity<?> deleteProduct(
            Authentication authentication,
            @PathVariable Long id
    ) {

        Long sellerId =
                Long.valueOf(
                        authentication.getName());

        sellerProductService
                .deleteProduct(
                        sellerId,
                        id);

        return ResponseEntity.ok(
                "Đã xóa sản phẩm");
    }
}