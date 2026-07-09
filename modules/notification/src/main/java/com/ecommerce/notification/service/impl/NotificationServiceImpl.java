package com.ecommerce.notification.service.impl;

import com.ecommerce.notification.dto.NotificationResponse;
import com.ecommerce.notification.repository.NotificationRepository;
import com.ecommerce.notification.service.NotificationService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class NotificationServiceImpl
        implements NotificationService {

    private final NotificationRepository notificationRepository;

    @Override
    public List<NotificationResponse> getNotifications(
            Long receiverId
    ) {

        return notificationRepository
                .findByUserIdOrderByCreatedAtDesc(receiverId)
                .stream()
                .map(notification ->
                        NotificationResponse.builder()
                                .id(notification.getId())
                                .title(notification.getTitle())
                                .message(notification.getMessage())
                                .type(notification.getType().name())
                                .isRead(notification.getIsRead())
                                .createdAt(notification.getCreatedAt())
                                .build())
                .toList();
    }
}