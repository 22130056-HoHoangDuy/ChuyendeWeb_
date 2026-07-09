package com.ecommerce.common.security;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfigurationSource;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity
@RequiredArgsConstructor
public class SharedSecurityConfig {

    private final JwtAuthenticationFilter jwtAuthenticationFilter;
    private final CorsConfigurationSource corsConfigurationSource;

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .cors(cors -> cors.configurationSource(corsConfigurationSource))
                .csrf(AbstractHttpConfigurer::disable)
                .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                /*
                 * Authorization Strategy
                 *
                 * Phase P0:
                 * - Public endpoints: auth, public product, payment callback
                 * - All remaining endpoints require authentication.
                 *
                 * Phase P1:
                 * - Introduce RBAC:
                 *   ROLE_ADMIN
                 *   ROLE_SELLER
                 *   ROLE_BUYER
                 */
                .authorizeHttpRequests(auth -> auth

                        .requestMatchers("/api/v1/auth/**").permitAll()

                        .requestMatchers(
                                "/api/v1/products/active",
                                "/api/v1/products/detail/**"
                        ).permitAll()

                        .requestMatchers("/api/v1/payments/callback/**").permitAll()
                        .requestMatchers("/api/v1/payments/webhook/**").permitAll()

                        // ADMIN
                        .requestMatchers("/api/v1/admin/**")
                        .hasRole("ADMIN")

                        // SELLER
                        .requestMatchers(HttpMethod.POST, "/api/v1/products/**")
                        .hasRole("SELLER")

                        // BUYER
                        .requestMatchers("/api/v1/orders/**")
                        .hasRole("BUYER")

                        .requestMatchers("/api/v1/payments/**")
                        .hasRole("BUYER")

                        .anyRequest().authenticated()
                );
        http.addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class);

        return http.build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}