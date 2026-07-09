package com.ecommerce.payment.repository;

import com.ecommerce.payment.domain.StoredPaymentMethod;
import com.ecommerce.payment.enums.PaymentProvider;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface PaymentStoredMethodRepository extends JpaRepository<StoredPaymentMethod, Long> {

    boolean existsByBuyerId(Long buyerId);

    Optional<StoredPaymentMethod> findByBuyerIdAndIsDefaultTrue(Long buyerId);

    Optional<StoredPaymentMethod> findByProviderAndExternalToken(
            PaymentProvider provider,
            String token
    );
}