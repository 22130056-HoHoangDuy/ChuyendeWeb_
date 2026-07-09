package com.ecommerce.common.security;

public interface CurrentUserProvider {

    Long getCurrentUserId();

    String getCurrentUserEmail();

}