package com.ecommerce.user.dto.response;

import com.ecommerce.user.domain.Address; // Đảm bảo đã import Address entity
import com.ecommerce.user.domain.User;
import com.ecommerce.user.dto.request.AddressDto;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

public record UserProfileResponse(
        Long id,
        String email,
        String fullName,
        String avatar,
        Integer age,
        String phone,
        List<AddressDto> addresses, // Thay vì 1 địa chỉ, ta trả về cả danh sách
        boolean enabled,
        LocalDateTime createdAt,
        List<RoleResponse> roles
) {
    public static UserProfileResponse fromEntity(User user) {
        // Ánh xạ danh sách Address entity sang AddressDto
        List<AddressDto> addressDtos = user.getAddresses().stream()
                .map(addr -> new AddressDto(
                        addr.getCountry(),
                        addr.getProvince(),
                        addr.getDistrict(),
                        addr.getStreet(),
                        addr.getHouseNumber()
                ))
                .collect(Collectors.toList());

        return new UserProfileResponse(
                user.getId(),
                user.getEmail(),
                user.getFullName(),
                user.getAvatar(),
                user.getAge(),
                user.getPhone(),
                addressDtos,
                user.isEnabled(),
                user.getCreatedAt(),
                user.getRoles().stream()
                        .map(r -> new RoleResponse(r.getName()))
                        .toList()
        );
    }
}