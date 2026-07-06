package com.ecommerce.user.dto.request;

public record AddressDto(
        String country,
        String province,
        String district,
        String street,
        String houseNumber
) {}