-- =====================================================
-- MODULE: USER
-- TABLE: users
-- =====================================================

CREATE TABLE users (
                       id BIGINT AUTO_INCREMENT PRIMARY KEY,

                       email VARCHAR(100) NOT NULL UNIQUE,

                       password VARCHAR(255),

                       full_name VARCHAR(255),

                       avatar VARCHAR(512),

                       age INT,

                       phone VARCHAR(20) UNIQUE,

                       enabled BOOLEAN NOT NULL DEFAULT TRUE,

                       created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- TABLE: roles
-- =====================================================

CREATE TABLE roles (
                       id BIGINT AUTO_INCREMENT PRIMARY KEY,

                       role_name VARCHAR(100) NOT NULL UNIQUE
);

-- =====================================================
-- TABLE: user_roles
-- =====================================================

CREATE TABLE user_roles (

                            user_id BIGINT NOT NULL,

                            role_id BIGINT NOT NULL,

                            PRIMARY KEY (user_id, role_id),

                            CONSTRAINT fk_user_roles_user
                                FOREIGN KEY (user_id)
                                    REFERENCES users(id)
                                    ON DELETE CASCADE,

                            CONSTRAINT fk_user_roles_role
                                FOREIGN KEY (role_id)
                                    REFERENCES roles(id)
                                    ON DELETE CASCADE
);

-- =====================================================
-- INDEX
-- =====================================================

CREATE INDEX idx_users_email
    ON users(email);

CREATE INDEX idx_user_roles_role
    ON user_roles(role_id);

-- =====================================================
-- TABLE: refresh_tokens
-- =====================================================

CREATE TABLE refresh_tokens (

                                id BIGINT AUTO_INCREMENT PRIMARY KEY,

                                user_id BIGINT NOT NULL UNIQUE,

                                token VARCHAR(255) NOT NULL UNIQUE,

                                expiry_date TIMESTAMP NOT NULL,

                                CONSTRAINT fk_refresh_token_user
                                    FOREIGN KEY (user_id)
                                        REFERENCES users(id)
                                        ON DELETE CASCADE
);

-- =====================================================
-- TABLE: password_reset_codes
-- =====================================================

CREATE TABLE password_reset_codes (

                                      id BIGINT AUTO_INCREMENT PRIMARY KEY,

                                      email VARCHAR(255) NOT NULL,

                                      code VARCHAR(6) NOT NULL,

                                      expiration_time TIMESTAMP NOT NULL,

                                      used BOOLEAN NOT NULL DEFAULT FALSE,

                                      created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_password_reset_email
    ON password_reset_codes(email);

-- =====================================================
-- TABLE: addresses
-- =====================================================

CREATE TABLE addresses (

                           id BIGINT AUTO_INCREMENT PRIMARY KEY,

                           country VARCHAR(100),

                           province VARCHAR(100),

                           district VARCHAR(100),

                           street VARCHAR(255),

                           house_number VARCHAR(100),

                           user_id BIGINT NOT NULL,

                           CONSTRAINT fk_address_user
                               FOREIGN KEY (user_id)
                                   REFERENCES users(id)
                                   ON DELETE CASCADE
);

CREATE INDEX idx_address_user
    ON addresses(user_id);