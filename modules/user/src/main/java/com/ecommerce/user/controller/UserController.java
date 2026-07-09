package com.ecommerce.user.controller;

import com.ecommerce.common.security.CurrentUserProvider;
import com.ecommerce.common.service.CloudinaryService;
import com.ecommerce.user.domain.User;
import com.ecommerce.user.dto.request.UserUpdateReq;
import com.ecommerce.user.dto.response.UserProfileResponse;
import com.ecommerce.user.service.UserService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;

@RestController
@RequestMapping("/api/v1/user")
@RequiredArgsConstructor
@CrossOrigin(origins = "*", allowedHeaders = "*")
@Slf4j
public class UserController {
    private final UserService userService;
    private final CloudinaryService cloudinaryService;
    private final CurrentUserProvider currentUserProvider;

    @PutMapping("/update_profile")
    public ResponseEntity<?> updateProfile(@Valid @RequestBody UserUpdateReq request) {
        String email = currentUserProvider.getCurrentUserEmail();
        log.info("Cập nhật thông tin profile cho: {}", email);
        return ResponseEntity.ok(userService.updateProfile(email, request));
    }

    @GetMapping("/profile")
    public ResponseEntity<?> getProfile() {
        String email = currentUserProvider.getCurrentUserEmail();
        log.info("Lấy thông tin profile cho: {}", email);
        User user = userService.getProfile(email);
        UserProfileResponse u = UserProfileResponse.fromEntity(user);
        return ResponseEntity.ok(u);
    }

    @PostMapping("/upload-avatar")
    public ResponseEntity<?> uploadAvatar(@RequestParam("file") MultipartFile file) {
        try {
            String email =
                    currentUserProvider.getCurrentUserEmail();
            log.info("Yêu cầu tải lên avatar mới cho user: {}", email);

            String avatarUrl = cloudinaryService.uploadImage(file);

            // Sửa tại đây: Thêm null cho tham số AddressDto thứ 5
            UserUpdateReq updateReq = new UserUpdateReq(null, avatarUrl, null, null, null);

            userService.updateProfile(email, updateReq);

            return ResponseEntity.ok(Map.of("avatar", avatarUrl, "message", "Cập nhật ảnh thành công!"));

        } catch (Exception e) {
            log.error("Lỗi upload ảnh: ", e);
            return ResponseEntity.badRequest().body(Map.of("message", "Lỗi khi tải ảnh lên máy chủ!"));
        }
    }


}