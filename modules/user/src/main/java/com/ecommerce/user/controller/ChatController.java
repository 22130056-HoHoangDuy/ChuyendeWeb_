package com.ecommerce.user.controller;

import com.ecommerce.common.security.CurrentUserProvider;
import com.ecommerce.user.service.ChatService;
import com.ecommerce.user.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/chat")
@RequiredArgsConstructor
public class ChatController {
    private final ChatService chatService;
    private final UserService userService;
    private final CurrentUserProvider currentUserProvider;

    @PostMapping("/send")
    public ResponseEntity<?> send(
            @RequestParam Long receiverId,
            @RequestBody String content
    ) {
        Long senderId =
                currentUserProvider.getCurrentUserId();
        return ResponseEntity.ok(chatService.sendMessage(senderId, receiverId, content));
    }

    @GetMapping("/history/{convId}")
    public ResponseEntity<?> getHistory(@PathVariable Long convId) {
        return ResponseEntity.ok(chatService.getMessagesByConversation(convId));
    }

    @GetMapping("/conversations")
    public ResponseEntity<?> getConversations() {

        Long userId =
                currentUserProvider.getCurrentUserId();

        return ResponseEntity.ok(
                chatService.getUserConversations(userId)
        );
    }
}
