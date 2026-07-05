package com.ecommerce.product.controller;

import com.ecommerce.product.service.SellerProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
}