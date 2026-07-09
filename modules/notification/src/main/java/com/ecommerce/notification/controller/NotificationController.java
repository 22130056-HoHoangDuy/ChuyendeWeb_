package com.ecommerce.notification.controller;

import com.ecommerce.common.security.CurrentUserProvider;
import com.ecommerce.notification.dto.NotificationResponse;
import com.ecommerce.notification.service.NotificationService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/v1/notifications")
@RequiredArgsConstructor
public class NotificationController {

    private final NotificationService notificationService;
    private final CurrentUserProvider currentUserProvider;

    @GetMapping
    public List<NotificationResponse> getNotifications() {

        Long userId = currentUserProvider.getCurrentUserId();

        return notificationService.getNotifications(userId);
    }
}