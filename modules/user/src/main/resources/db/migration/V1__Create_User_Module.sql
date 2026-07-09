-- =====================================================
-- MODULE: USER
-- TABLE: users
-- =====================================================

CREATE TABLE users
(
    id         BIGINT AUTO_INCREMENT PRIMARY KEY,

    email      VARCHAR(100) NOT NULL UNIQUE,

    password   VARCHAR(255),

    full_name  VARCHAR(255),

    avatar     VARCHAR(512),

    age        INT,

    phone      VARCHAR(20) UNIQUE,

    enabled    BOOLEAN      NOT NULL DEFAULT TRUE,

    created_at TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- TABLE: roles
-- =====================================================

CREATE TABLE roles
(
    id        BIGINT AUTO_INCREMENT PRIMARY KEY,

    role_name VARCHAR(100) NOT NULL UNIQUE
);

-- =====================================================
-- TABLE: user_roles
-- =====================================================

CREATE TABLE user_roles
(

    user_id BIGINT NOT NULL,

    role_id BIGINT NOT NULL,

    PRIMARY KEY (user_id, role_id),

    CONSTRAINT fk_user_roles_user
        FOREIGN KEY (user_id)
            REFERENCES users (id)
            ON DELETE CASCADE,

    CONSTRAINT fk_user_roles_role
        FOREIGN KEY (role_id)
            REFERENCES roles (id)
            ON DELETE CASCADE
);

-- =====================================================
-- INDEX
-- =====================================================

CREATE INDEX idx_users_email
    ON users (email);

CREATE INDEX idx_user_roles_role
    ON user_roles (role_id);

-- =====================================================
-- TABLE: refresh_tokens
-- =====================================================

CREATE TABLE refresh_tokens
(

    id          BIGINT AUTO_INCREMENT PRIMARY KEY,

    user_id     BIGINT       NOT NULL UNIQUE,

    token       VARCHAR(255) NOT NULL UNIQUE,

    expiry_date TIMESTAMP    NOT NULL,

    CONSTRAINT fk_refresh_token_user
        FOREIGN KEY (user_id)
            REFERENCES users (id)
            ON DELETE CASCADE
);

-- =====================================================
-- TABLE: password_reset_codes
-- =====================================================

CREATE TABLE password_reset_codes
(

    id              BIGINT AUTO_INCREMENT PRIMARY KEY,

    email           VARCHAR(255) NOT NULL,

    code            VARCHAR(6)   NOT NULL,

    expiration_time TIMESTAMP    NOT NULL,

    used            BOOLEAN      NOT NULL DEFAULT FALSE,

    created_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_password_reset_email
    ON password_reset_codes (email);

-- =====================================================
-- TABLE: addresses
-- =====================================================

CREATE TABLE addresses
(

    id           BIGINT AUTO_INCREMENT PRIMARY KEY,

    country      VARCHAR(100),

    province     VARCHAR(100),

    district     VARCHAR(100),

    street       VARCHAR(255),

    house_number VARCHAR(100),

    user_id      BIGINT NOT NULL,

    CONSTRAINT fk_address_user
        FOREIGN KEY (user_id)
            REFERENCES users (id)
            ON DELETE CASCADE
);

CREATE INDEX idx_address_user
    ON addresses (user_id);

-- =====================================================
-- TABLE: wallets
-- =====================================================

CREATE TABLE wallets
(

    id         BIGINT AUTO_INCREMENT PRIMARY KEY,

    user_id    BIGINT    NOT NULL,

    balance DOUBLE NOT NULL DEFAULT 0.0,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT uk_wallet_user
        UNIQUE (user_id),

    CONSTRAINT fk_wallet_user
        FOREIGN KEY (user_id)
            REFERENCES users (id)
            ON DELETE CASCADE
);

CREATE INDEX idx_wallet_user
    ON wallets (user_id);

-- =====================================================
-- TABLE: conversations
-- =====================================================

CREATE TABLE conversations
(

    id              BIGINT AUTO_INCREMENT PRIMARY KEY,

    buyer_id        BIGINT NOT NULL,

    seller_id       BIGINT NOT NULL,

    last_message_at TIMESTAMP NULL,

    CONSTRAINT fk_conversation_buyer
        FOREIGN KEY (buyer_id)
            REFERENCES users (id)
            ON DELETE CASCADE,

    CONSTRAINT fk_conversation_seller
        FOREIGN KEY (seller_id)
            REFERENCES users (id)
            ON DELETE CASCADE
);

CREATE INDEX idx_conversation_buyer
    ON conversations (buyer_id);

CREATE INDEX idx_conversation_seller
    ON conversations (seller_id);

CREATE INDEX idx_conversation_last_message
    ON conversations (last_message_at);

-- =====================================================
-- TABLE: messages
-- =====================================================

CREATE TABLE messages
(

    id              BIGINT AUTO_INCREMENT PRIMARY KEY,

    conversation_id BIGINT    NOT NULL,

    sender_id       BIGINT    NOT NULL,

    content         TEXT      NOT NULL,

    created_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_message_conversation
        FOREIGN KEY (conversation_id)
            REFERENCES conversations (id)
            ON DELETE CASCADE,

    CONSTRAINT fk_message_sender
        FOREIGN KEY (sender_id)
            REFERENCES users (id)
            ON DELETE CASCADE
);

CREATE INDEX idx_message_conversation
    ON messages (conversation_id);

CREATE INDEX idx_message_sender
    ON messages (sender_id);

CREATE INDEX idx_message_created
    ON messages (created_at);

-- =====================================================
-- TABLE: notifications
-- =====================================================

CREATE TABLE notifications
(

    id          BIGINT AUTO_INCREMENT PRIMARY KEY,

    receiver_id BIGINT       NOT NULL,

    title       VARCHAR(255) NOT NULL,

    message     TEXT,

    type        ENUM(
        'ORDER_CREATED',
        'ORDER_CONFIRMED',
        'ORDER_DELIVERING',
        'ORDER_COMPLETED',
        'PAYMENT_SUCCESS',
        'PAYMENT_FAILED',
        'SYSTEM'
    ) NOT NULL,

    is_read     BOOLEAN      NOT NULL DEFAULT FALSE,

    created_at  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_notification_user
        FOREIGN KEY (receiver_id)
            REFERENCES users (id)
            ON DELETE CASCADE
);

-- =====================================================
-- INDEX
-- =====================================================

CREATE INDEX idx_notification_user
    ON notifications (receiver_id);

CREATE INDEX idx_notification_type
    ON notifications (type);

CREATE INDEX idx_notification_read
    ON notifications (is_read);

CREATE INDEX idx_notification_created
    ON notifications (created_at);