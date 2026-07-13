package com.ecommerce.payment.enums;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;
@Converter(autoApply = true)
public class PaymentStatusConverter implements AttributeConverter<PaymentSessionStatus, String> {

    @Override
    public String convertToDatabaseColumn(PaymentSessionStatus status) {
        return status == null ? null : status.name().toLowerCase();
    }

    @Override
    public PaymentSessionStatus convertToEntityAttribute(String dbData) {
        if (dbData == null || dbData.trim().isEmpty()) return null;
        try {
            return PaymentSessionStatus.valueOf(dbData.trim().toUpperCase());
        } catch (IllegalArgumentException e) {
            throw new RuntimeException("Giá trị trạng thái không hợp lệ trong DB: " + dbData);
        }
    }
}