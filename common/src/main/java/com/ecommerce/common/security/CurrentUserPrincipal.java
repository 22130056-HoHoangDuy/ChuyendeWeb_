package com.ecommerce.common.security;

import org.springframework.security.core.GrantedAuthority;

import java.io.Serializable;
import java.util.Collection;

public record CurrentUserPrincipal(
        Long userId,
        String email,
        Collection<? extends GrantedAuthority> authorities
) implements Serializable {
}