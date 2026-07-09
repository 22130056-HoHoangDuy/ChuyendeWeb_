package com.ecommerce.notification.service;

import com.ecommerce.notification.dto.NotificationResponse;

import java.util.List;

public interface NotificationService {
    List<NotificationResponse> getNotifications(
            Long receiverId
    );
}
