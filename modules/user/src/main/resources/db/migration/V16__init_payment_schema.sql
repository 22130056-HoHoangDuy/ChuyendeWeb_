-- 1. Tạo bảng payment_sessions
CREATE TABLE IF NOT EXISTS payment_sessions (
                                                id BIGINT AUTO_INCREMENT PRIMARY KEY,
                                                order_id BIGINT NOT NULL,
                                                amount DECIMAL(19, 2),                 -- Khớp với Embedded Money totalAmount
                                                currency VARCHAR(10),
                                                status VARCHAR(20) NOT NULL,
                                                idempotency_key VARCHAR(100) NOT NULL,
                                                created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

                                                UNIQUE KEY uk_payment_sessions_order_id (order_id),
                                                UNIQUE KEY uk_payment_sessions_idempotency (idempotency_key),
                                                CONSTRAINT payment_sessions_status_check CHECK (status IN (
                                                                                                           'PENDING', 'PROCESSING', 'COMPLETED', 'FAILED', 'EXPIRED', 'CANCELLED'
                                                    ))
) ENGINE=InnoDB;

-- 2. Tạo bảng payment_transactions
CREATE TABLE IF NOT EXISTS payment_transactions (
                                                    id BIGINT AUTO_INCREMENT PRIMARY KEY,
                                                    session_id BIGINT NOT NULL,            -- Khóa ngoại trỏ sang payment_sessions
                                                    provider VARCHAR(20) NOT NULL,         -- Lưu MOMO, VNPAY, PAYPAL
                                                    type VARCHAR(20) NOT NULL,             -- Lưu CHARGE, REFUND
                                                    status VARCHAR(20) NOT NULL,           -- Lưu SUCCESS, FAILED, PENDING...
                                                    gateway VARCHAR(255),                  -- Cột 'gateway' lưu PayerID/BankCode
                                                    gateway_txn_id VARCHAR(100) NOT NULL,  -- Cột 'gateway_txn_id' lưu token/TransactionNo
                                                    amount DECIMAL(19, 2),
                                                    currency VARCHAR(10),
                                                    failure_reason TEXT,
                                                    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                                    updated_at TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,

                                                    CONSTRAINT fk_transactions_on_session FOREIGN KEY (session_id)
                                                        REFERENCES payment_sessions (id) ON DELETE CASCADE,
                                                    UNIQUE KEY uk_gateway_txn_id (gateway_txn_id),
                                                    CONSTRAINT payment_transactions_status_check CHECK (status IN (
                                                                                                                   'PENDING', 'AUTHORIZED', 'SUCCESS', 'FAILED', 'CANCELLED', 'EXPIRED'
                                                        ))
) ENGINE=InnoDB;

-- 3. Tạo bảng stored_payment_methods
CREATE TABLE IF NOT EXISTS stored_payment_methods (
                                                      id BIGINT AUTO_INCREMENT PRIMARY KEY,
                                                      user_id BIGINT NOT NULL,
                                                      provider VARCHAR(30) NOT NULL,
                                                      external_token VARCHAR(255) NOT NULL,
                                                      is_default BOOLEAN DEFAULT FALSE,
                                                      status VARCHAR(20) NOT NULL,
                                                      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

                                                      CONSTRAINT uk_provider_external_token UNIQUE (provider, external_token),
                                                      CONSTRAINT stored_payment_status_check CHECK (status IN ('ACTIVE', 'INACTIVE'))
) ENGINE=InnoDB;

-- 4. Các Index để tối ưu tìm kiếm theo đúng khai báo trong Entity
CREATE INDEX idx_session_id ON payment_transactions(session_id);
CREATE INDEX idx_provider_ref ON payment_transactions(gateway);
CREATE INDEX idx_txn_reference ON payment_transactions(gateway_txn_id);