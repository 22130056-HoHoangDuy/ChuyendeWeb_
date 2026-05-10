package com.ecommerce.payment.repository;

import com.ecommerce.payment.domain.PaymentSession;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface PaymentSessionRepository extends JpaRepository<PaymentSession, Long> {

    Optional<PaymentSession> findByOrderId(Long orderId);

    Optional<PaymentSession> findByIdempotencyKey(String idempotencyKey);
}