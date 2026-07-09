package com.ecommerce.user.controller;

import com.ecommerce.user.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/admin/users")
@RequiredArgsConstructor
public class AdminUserController {

    private final UserService userService;

    @PatchMapping("/buyers/{id}/status")
    public ResponseEntity<?> changeBuyerStatus(@PathVariable Long id, @RequestParam boolean enabled) {
        userService.updateUserStatus(id, enabled);
        String msg = enabled ? "Đã mở khóa tài khoản người mua" : "Đã khóa tài khoản người mua";
        return ResponseEntity.ok(msg);
    }

    @PatchMapping("/sellers/{id}/status")
    public ResponseEntity<?> changeSellerStatus(@PathVariable Long id, @RequestParam boolean enabled) {
        userService.updateUserStatus(id, enabled);
        String msg = enabled ? "Đã cho phép Seller hoạt động lại" : "Đã đình chỉ quyền bán hàng của Seller";
        return ResponseEntity.ok(msg);
    }

    @GetMapping("/list")
    public ResponseEntity<?> getUsers(
            @RequestParam(required = false)
            String role) {

        if (role != null) {
            return ResponseEntity.ok(
                    userService.findAllByRole(role));
        }

        return ResponseEntity.ok(
                userService.getAllUsers());
    }
    // detail user
    @GetMapping("/{id}")
    public ResponseEntity<?> getUser(
            @PathVariable Long id) {

        return ResponseEntity.ok(
                userService.getProfileById(id));
    }
}