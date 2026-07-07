-- =====================================================
-- MODULE: PRODUCT
-- TABLE: categories
-- =====================================================

CREATE TABLE categories (

                            id BIGINT AUTO_INCREMENT PRIMARY KEY,

                            name VARCHAR(255) NOT NULL UNIQUE
);

-- =====================================================
-- TABLE: products
-- =====================================================

CREATE TABLE products (

                          id BIGINT AUTO_INCREMENT PRIMARY KEY,

                          product_name VARCHAR(255) NOT NULL,

                          category_id BIGINT NOT NULL,

                          origin VARCHAR(255),

                          stock INT NOT NULL DEFAULT 0,

                          size VARCHAR(100),

                          avatar VARCHAR(512),

                          description TEXT,

                          embedding JSON,

                          CONSTRAINT fk_product_category
                              FOREIGN KEY (category_id)
                                  REFERENCES categories(id)
                                  ON DELETE RESTRICT
);

-- =====================================================
-- INDEX
-- =====================================================

CREATE INDEX idx_product_category
    ON products(category_id);

CREATE INDEX idx_product_name
    ON products(product_name);

-- =====================================================
-- TABLE: seller_products
-- =====================================================

CREATE TABLE seller_products (

                                 id BIGINT AUTO_INCREMENT PRIMARY KEY,

                                 seller_id BIGINT NOT NULL,

                                 product_id BIGINT NOT NULL,

                                 product_name VARCHAR(255),

                                 image_url VARCHAR(512),

                                 price DOUBLE NOT NULL,

                                 stock INT NOT NULL DEFAULT 0,

                                 sku VARCHAR(255) NOT NULL,

                                 status ENUM(
        'ACTIVE',
        'INACTIVE'
    ) NOT NULL DEFAULT 'ACTIVE',

                                 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

                                 updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
                                     ON UPDATE CURRENT_TIMESTAMP,

                                 CONSTRAINT fk_seller_product_user
                                     FOREIGN KEY (seller_id)
                                         REFERENCES users(id)
                                         ON DELETE CASCADE,

                                 CONSTRAINT fk_seller_product_product
                                     FOREIGN KEY (product_id)
                                         REFERENCES products(id)
                                         ON DELETE CASCADE
);

-- =====================================================
-- INDEX
-- =====================================================

CREATE INDEX idx_seller_product_seller
    ON seller_products(seller_id);

CREATE INDEX idx_seller_product_product
    ON seller_products(product_id);

CREATE INDEX idx_seller_product_status
    ON seller_products(status);

CREATE INDEX idx_seller_product_price
    ON seller_products(price);

CREATE INDEX idx_seller_product_sku
    ON seller_products(sku);

-- =====================================================
-- TABLE: wishlist
-- =====================================================

CREATE TABLE wishlist (

                          id BIGINT AUTO_INCREMENT PRIMARY KEY,

                          user_id BIGINT NOT NULL,

                          seller_product_id BIGINT NOT NULL,

                          created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

                          CONSTRAINT fk_wishlist_user
                              FOREIGN KEY (user_id)
                                  REFERENCES users(id)
                                  ON DELETE CASCADE,

                          CONSTRAINT fk_wishlist_product
                              FOREIGN KEY (seller_product_id)
                                  REFERENCES seller_products(id)
                                  ON DELETE CASCADE,

                          CONSTRAINT uk_wishlist_user_product
                              UNIQUE(user_id, seller_product_id)
);

CREATE INDEX idx_wishlist_user
    ON wishlist(user_id);

CREATE INDEX idx_wishlist_product
    ON wishlist(seller_product_id);
