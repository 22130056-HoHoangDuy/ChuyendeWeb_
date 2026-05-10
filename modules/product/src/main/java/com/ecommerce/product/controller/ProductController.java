package com.ecommerce.product.controller;

import com.ecommerce.product.dto.request.ProductRequest;
import com.ecommerce.product.dto.response.ProductHomeResponse;
import com.ecommerce.product.service.ProductService;
import lombok.RequiredArgsConstructor;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.core.Authentication;
import java.util.List;
@Slf4j
@RestController
@RequestMapping("/api/v1/products")
@RequiredArgsConstructor
public class ProductController {

    private final ProductService productService;

    @PostMapping
    public ResponseEntity<?> create(@RequestBody ProductRequest request) {
        return ResponseEntity.ok(productService.createProduct(request));
    }

    @GetMapping
    public ResponseEntity<?> getAll() {
        return ResponseEntity.ok(productService.getAll());
    }

    @PostMapping("/semantic-search")
    public ResponseEntity<?> search(@RequestBody List<Double> queryVector) {
        return ResponseEntity.ok(productService.searchSemantic(queryVector));
    }

    @GetMapping("/active")
    public ResponseEntity<List<ProductHomeResponse>> getHomeProducts(Authentication authentication) {
        Long userId = null;
        if (authentication != null && authentication.isAuthenticated()) {
            try {
                userId = Long.valueOf(authentication.getName());
                log.info(userId.toString());
            } catch (Exception e) {
                userId = null;
            }
        }

        List<ProductHomeResponse> responses = productService.getAllActiveForHomePage(userId);
        return ResponseEntity.ok(responses);
    }

    @GetMapping("/seller/{sellerId}/active")
    public ResponseEntity<?> getProductsBySeller(@PathVariable Long sellerId) {
        return ResponseEntity.ok(productService.getAllActiveBySeller(sellerId));
    }

    @CrossOrigin("*")
    @GetMapping("/detail/{id}")
    public ResponseEntity<?> getProductDetail(@PathVariable Long id) {
        log.info("Đang lấy chi tiết cho SellerProduct ID: {}", id);
        return ResponseEntity.ok(productService.getProductDetail(id));
    }
}