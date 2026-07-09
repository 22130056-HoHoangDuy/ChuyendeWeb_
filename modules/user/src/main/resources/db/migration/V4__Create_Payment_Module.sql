-- =====================================================
-- MODULE: PAYMENT
-- TABLE: payment_sessions
-- =====================================================

CREATE TABLE payment_sessions (

                                  id BIGINT AUTO_INCREMENT PRIMARY KEY,

                                  order_id BIGINT NOT NULL,

                                  amount DECIMAL(19,2) NOT NULL,

                                  currency VARCHAR(10) NOT NULL,

                                  status ENUM(
        'PENDING',
        'PROCESSING',
        'COMPLETED',
        'FAILED',
        'EXPIRED',
        'CANCELLED'
    ) NOT NULL DEFAULT 'PENDING',

                                  idempotency_key VARCHAR(100) NOT NULL,

                                  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

                                  CONSTRAINT uk_payment_session_order
                                      UNIQUE(order_id),

                                  CONSTRAINT uk_payment_session_idempotency
                                      UNIQUE(idempotency_key),

                                  CONSTRAINT fk_payment_session_order
                                      FOREIGN KEY (order_id)
                                          REFERENCES orders(id)
                                          ON DELETE RESTRICT
);

-- =====================================================
-- INDEX
-- =====================================================

CREATE INDEX idx_payment_session_status
    ON payment_sessions(status);

CREATE INDEX idx_payment_session_created
    ON payment_sessions(created_at);

-- =====================================================
-- TABLE: payment_transactions
-- =====================================================

CREATE TABLE payment_transactions (

                                      id BIGINT AUTO_INCREMENT PRIMARY KEY,

                                      session_id BIGINT NOT NULL,

                                      provider ENUM(
        'MOMO',
        'VNPAY',
        'PAYPAL'
    ) NOT NULL,

                                      type ENUM(
        'CHARGE',
        'REFUND'
    ) NOT NULL,

                                      status ENUM(
        'PENDING',
        'AUTHORIZED',
        'SUCCESS',
        'FAILED',
        'CANCELLED',
        'EXPIRED'
    ) NOT NULL DEFAULT 'PENDING',

                                      gateway VARCHAR(255),

                                      gateway_txn_id VARCHAR(100) NOT NULL,

                                      amount DECIMAL(19,2) NOT NULL,

                                      currency VARCHAR(10) NOT NULL,

                                      failure_reason TEXT,

                                      created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

                                      updated_at TIMESTAMP NULL DEFAULT NULL
        ON UPDATE CURRENT_TIMESTAMP,

                                      CONSTRAINT uk_gateway_transaction
                                          UNIQUE(gateway_txn_id),

                                      CONSTRAINT fk_payment_transaction_session
                                          FOREIGN KEY (session_id)
                                              REFERENCES payment_sessions(id)
                                              ON DELETE CASCADE
);

-- =====================================================
-- INDEX
-- =====================================================

CREATE INDEX idx_payment_transaction_session
    ON payment_transactions(session_id);

CREATE INDEX idx_payment_transaction_provider
    ON payment_transactions(provider);

CREATE INDEX idx_payment_transaction_status
    ON payment_transactions(status);

CREATE INDEX idx_payment_transaction_gateway
    ON payment_transactions(gateway);

CREATE INDEX idx_payment_transaction_created
    ON payment_transactions(created_at);

-- =====================================================
-- TABLE: stored_payment_methods
-- =====================================================

CREATE TABLE stored_payment_methods (

                                        id BIGINT AUTO_INCREMENT PRIMARY KEY,

                                        buyer_id BIGINT NOT NULL,

                                        provider ENUM(
        'MOMO',
        'VNPAY',
        'PAYPAL'
    ) NOT NULL,

                                        external_token VARCHAR(255) NOT NULL,

                                        is_default BOOLEAN NOT NULL DEFAULT FALSE,

                                        status ENUM(
        'ACTIVE',
        'INACTIVE'
    ) NOT NULL DEFAULT 'ACTIVE',

                                        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

                                        CONSTRAINT uk_provider_external_token
                                            UNIQUE(provider, external_token),

                                        CONSTRAINT fk_stored_payment_user
                                            FOREIGN KEY (buyer_id)
                                                REFERENCES users(buyer_id)
                                                ON DELETE CASCADE
);

-- =====================================================
-- INDEX
-- =====================================================

CREATE INDEX idx_payment_method_user
    ON stored_payment_methods(buyer_id);

CREATE INDEX idx_payment_method_provider
    ON stored_payment_methods(provider);

CREATE INDEX idx_payment_method_status
    ON stored_payment_methods(status);

CREATE INDEX idx_payment_method_default
    ON stored_payment_methods(is_default);