package com.ecommerce.user.service;

import com.ecommerce.user.domain.Conversation;
import com.ecommerce.user.domain.Message;

import java.util.List;

public interface ChatService {
    Message sendMessage(Long senderId, Long receiverId, String content);

    List<Message> getMessagesByConversation(Long convId);

    List<Conversation> getUserConversations(Long userId);
}
