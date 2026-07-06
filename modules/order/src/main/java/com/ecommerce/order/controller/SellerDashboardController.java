package com.ecommerce.order.controller;

import com.ecommerce.common.security.CurrentUserProvider;
import com.ecommerce.order.service.SellerDashboardService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/seller")
@RequiredArgsConstructor
public class SellerDashboardController {

    private final SellerDashboardService service;
    private final CurrentUserProvider currentUserProvider;

    @GetMapping("/dashboard")
    public ResponseEntity<?> dashboard() {

        return ResponseEntity.ok(
                service.getDashboard(
                        currentUserProvider
                                .getCurrentUserId()));
    }
}