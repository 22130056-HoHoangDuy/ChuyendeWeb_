package com.ecommerce.order.enums;

import java.util.List;

public enum OrderStatus {

    PENDING,
    PAID,
    PROCESSING,
    SHIPPING,
    DELIVERED,
    CANCELLED,
    RETURNED;

    public boolean canTransitionTo(OrderStatus next) {

        if (this == next) {
            return true;
        }

        return switch (this) {

            case PENDING -> List.of(
                    PAID,
                    CANCELLED
            ).contains(next);

            case PAID -> List.of(
                    PROCESSING,
                    CANCELLED
            ).contains(next);

            case PROCESSING -> List.of(
                    SHIPPING,
                    CANCELLED
            ).contains(next);

            case SHIPPING -> List.of(
                    DELIVERED,
                    RETURNED
            ).contains(next);

            case DELIVERED -> List.of(
                    RETURNED
            ).contains(next);

            case CANCELLED,
                 RETURNED -> false;
        };
    }

    public boolean isFinalState() {
        return switch (this) {
            case DELIVERED,
                 CANCELLED,
                 RETURNED -> true;
            default -> false;
        };
    }
}