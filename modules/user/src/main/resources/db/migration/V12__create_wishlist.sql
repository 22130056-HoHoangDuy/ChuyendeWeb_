CREATE TABLE IF NOT EXISTS wishlist (
                                        id BIGINT AUTO_INCREMENT PRIMARY KEY,
                                        user_id BIGINT NOT NULL,
                                        seller_product_id BIGINT NOT NULL,
                                        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

                                        UNIQUE KEY unique_user_product (user_id, seller_product_id),

                                        CONSTRAINT fk_wishlist_seller_product
                                            FOREIGN KEY (seller_product_id)
                                                REFERENCES seller_products(id)
                                                ON DELETE CASCADE
) ENGINE=InnoDB;