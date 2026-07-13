package com.ecommerce.payment.enums;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

@Converter(autoApply = true)
public class PaymentTransactionStatusConverter implements AttributeConverter<PaymentTransactionStatus, String> {
    @Override
    public String convertToDatabaseColumn(PaymentTransactionStatus status) {
        return status == null ? null : status.name().toLowerCase();
    }

    @Override
    public PaymentTransactionStatus convertToEntityAttribute(String dbData) {
        if (dbData == null || dbData.trim().isEmpty()) return null;
        try {
            return PaymentTransactionStatus.valueOf(dbData.trim().toUpperCase());
        } catch (IllegalArgumentException e) {
            throw new RuntimeException("Giá trị trạng thái không hợp lệ trong DB: " + dbData);
        }
    }
}