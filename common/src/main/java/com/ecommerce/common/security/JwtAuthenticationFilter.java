package com.ecommerce.common.security;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Component
@RequiredArgsConstructor
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtProvider jwtProvider;

//    @Override
//    protected void doFilterInternal(HttpServletRequest request,
//                                    HttpServletResponse response,
//                                    FilterChain filterChain) throws ServletException, IOException {
//        String token = getJwtFromRequest(request);
//        if (StringUtils.hasText(token) && jwtProvider.validateToken(token)) {
//            String email = jwtProvider.getEmailFromToken(token);
//            List<GrantedAuthority> authorities = jwtProvider.getAuthoritiesFromToken(token);
//            UsernamePasswordAuthenticationToken authentication =
//                    new UsernamePasswordAuthenticationToken(email, null, authorities    );
//            authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
//
//            SecurityContextHolder.getContext().setAuthentication(authentication);
//        }
//
//        filterChain.doFilter(request, response);
//    }
@Override
protected void doFilterInternal(HttpServletRequest request,
                                HttpServletResponse response,
                                FilterChain filterChain) throws ServletException, IOException {

    // 1. Danh sách các path được phép truy cập không cần token
    String path = request.getRequestURI();
    if (path.startsWith("/api/v1/cart/") ||
            path.startsWith("/api/v1/auth/") ||
            path.startsWith("/api/v1/products/")) {

        filterChain.doFilter(request, response);
        return;
    }

    // 2. Logic kiểm tra JWT hiện tại (chỉ chạy cho các path yêu cầu bảo mật)
    String token = getJwtFromRequest(request);
    if (StringUtils.hasText(token) && jwtProvider.validateToken(token)) {
        String email = jwtProvider.getEmailFromToken(token);
        List<GrantedAuthority> authorities = jwtProvider.getAuthoritiesFromToken(token);
        UsernamePasswordAuthenticationToken authentication =
                new UsernamePasswordAuthenticationToken(email, null, authorities);
        authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));

        SecurityContextHolder.getContext().setAuthentication(authentication);
    }

    filterChain.doFilter(request, response);
}

    private String getJwtFromRequest(HttpServletRequest request) {
        String bearerToken = request.getHeader("Authorization");
        if (StringUtils.hasText(bearerToken) && bearerToken.startsWith("Bearer ")) {
            return bearerToken.substring(7);
        }
        return null;
    }
}