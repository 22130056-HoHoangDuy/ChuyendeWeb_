-- =====================================================
-- MODULE: ORDER
-- TABLE: carts
-- =====================================================

CREATE TABLE carts (

                       id BIGINT AUTO_INCREMENT PRIMARY KEY,

                       user_id BIGINT NOT NULL,

                       CONSTRAINT uk_cart_user
                           UNIQUE(user_id),

                       CONSTRAINT fk_cart_user
                           FOREIGN KEY (user_id)
                               REFERENCES users(id)
                               ON DELETE CASCADE
);

CREATE INDEX idx_cart_user
    ON carts(user_id);

-- =====================================================
-- TABLE: cart_items
-- =====================================================

CREATE TABLE cart_items (

                            id BIGINT AUTO_INCREMENT PRIMARY KEY,

                            cart_id BIGINT NOT NULL,

                            seller_product_id BIGINT NOT NULL,

                            quantity INT NOT NULL DEFAULT 1,

                            CONSTRAINT chk_cart_quantity
                                CHECK (quantity > 0),

                            CONSTRAINT fk_cart_item_cart
                                FOREIGN KEY (cart_id)
                                    REFERENCES carts(id)
                                    ON DELETE CASCADE,

                            CONSTRAINT fk_cart_item_product
                                FOREIGN KEY (seller_product_id)
                                    REFERENCES seller_products(id)
                                    ON DELETE CASCADE,

                            CONSTRAINT uk_cart_product
                                UNIQUE(cart_id, seller_product_id)
);

CREATE INDEX idx_cart_item_cart
    ON cart_items(cart_id);

CREATE INDEX idx_cart_item_product
    ON cart_items(seller_product_id);

-- =====================================================
-- TABLE: orders
-- =====================================================

CREATE TABLE orders (

                        id BIGINT AUTO_INCREMENT PRIMARY KEY,

                        user_id BIGINT NOT NULL,

                        seller_id BIGINT NOT NULL,

                        order_status ENUM(
        'PENDING',
        'PAID',
        'PROCESSING',
        'SHIPPING',
        'DELIVERED',
        'CANCELLED',
        'RETURNED'
    ) NOT NULL DEFAULT 'PENDING',

                        shipping_address VARCHAR(255),

                        total_price DOUBLE NOT NULL DEFAULT 0,

                        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

                        updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
                            ON UPDATE CURRENT_TIMESTAMP,

                        CONSTRAINT fk_order_user
                            FOREIGN KEY (user_id)
                                REFERENCES users(id)
                                ON DELETE RESTRICT,

                        CONSTRAINT fk_order_seller
                            FOREIGN KEY (seller_id)
                                REFERENCES users(id)
                                ON DELETE RESTRICT
);

CREATE INDEX idx_order_user
    ON orders(user_id);

CREATE INDEX idx_order_seller
    ON orders(seller_id);

CREATE INDEX idx_order_status
    ON orders(order_status);

CREATE INDEX idx_order_created_at
    ON orders(created_at);

-- =====================================================
-- TABLE: order_items
-- =====================================================

CREATE TABLE order_items (

                             id BIGINT AUTO_INCREMENT PRIMARY KEY,

                             order_id BIGINT NOT NULL,

                             seller_product_id BIGINT NOT NULL,

                             quantity INT NOT NULL,

                             price DOUBLE NOT NULL,

                             created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

                             updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
                                 ON UPDATE CURRENT_TIMESTAMP,

                             CONSTRAINT chk_order_quantity
                                 CHECK (quantity > 0),

                             CONSTRAINT chk_order_price
                                 CHECK (price >= 0),

                             CONSTRAINT fk_order_item_order
                                 FOREIGN KEY (order_id)
                                     REFERENCES orders(id)
                                     ON DELETE CASCADE,

                             CONSTRAINT fk_order_item_product
                                 FOREIGN KEY (seller_product_id)
                                     REFERENCES seller_products(id)
                                     ON DELETE RESTRICT
);

CREATE INDEX idx_order_item_order
    ON order_items(order_id);

CREATE INDEX idx_order_item_product
    ON order_items(seller_product_id);

-- =====================================================
-- TABLE: return_requests
-- =====================================================

CREATE TABLE return_requests (

                                 id BIGINT AUTO_INCREMENT PRIMARY KEY,

                                 order_item_id BIGINT NOT NULL,

                                 customer_id BIGINT NOT NULL,

                                 seller_id BIGINT NOT NULL,

                                 return_reason TEXT,

                                 evidence_image_urls TEXT,

                                 status ENUM(
        'PENDING',
        'APPROVED',
        'REJECTED',
        'WAITING_RETURN',
        'RECEIVED',
        'COMPLETED'
    ) NOT NULL DEFAULT 'PENDING',

                                 note VARCHAR(500),

                                 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

                                 updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
                                     ON UPDATE CURRENT_TIMESTAMP,

                                 CONSTRAINT fk_return_order_item
                                     FOREIGN KEY (order_item_id)
                                         REFERENCES order_items(id)
                                         ON DELETE RESTRICT,

                                 CONSTRAINT fk_return_customer
                                     FOREIGN KEY (customer_id)
                                         REFERENCES users(id)
                                         ON DELETE RESTRICT,

                                 CONSTRAINT fk_return_seller
                                     FOREIGN KEY (seller_id)
                                         REFERENCES users(id)
                                         ON DELETE RESTRICT
);

CREATE INDEX idx_return_order_item
    ON return_requests(order_item_id);

CREATE INDEX idx_return_customer
    ON return_requests(customer_id);

CREATE INDEX idx_return_seller
    ON return_requests(seller_id);

CREATE INDEX idx_return_status
    ON return_requests(status);

-- =====================================================
-- TABLE: return_refunds
-- =====================================================

CREATE TABLE return_refunds (

                                id BIGINT AUTO_INCREMENT PRIMARY KEY,

                                return_request_id BIGINT NOT NULL,

                                refund_amount DOUBLE NOT NULL,

                                status ENUM(
        'PENDING',
        'SUCCESS',
        'FAILED',
        'COMPLETED'
    ) NOT NULL DEFAULT 'COMPLETED',

                                request_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

                                CONSTRAINT uk_return_refund_request
                                    UNIQUE(return_request_id),

                                CONSTRAINT chk_refund_amount
                                    CHECK (refund_amount >= 0),

                                CONSTRAINT fk_return_refund_request
                                    FOREIGN KEY (return_request_id)
                                        REFERENCES return_requests(id)
                                        ON DELETE CASCADE
);

CREATE INDEX idx_return_refund_status
    ON return_refunds(status);