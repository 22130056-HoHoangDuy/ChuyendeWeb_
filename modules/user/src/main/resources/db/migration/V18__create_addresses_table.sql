CREATE TABLE addresses (
                           id BIGINT AUTO_INCREMENT PRIMARY KEY,
                           country VARCHAR(100),
                           province VARCHAR(100),
                           district VARCHAR(100),
                           street VARCHAR(255),
                           house_number VARCHAR(100),
                           user_id BIGINT NOT NULL,
                           CONSTRAINT fk_address_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);