ALTER TABLE seller_products
    ADD COLUMN product_name VARCHAR(255),
    ADD COLUMN image_url VARCHAR(512);

UPDATE seller_products sp
    JOIN products p ON sp.product_id = p.id
SET sp.product_name = p.product_name,
    sp.image_url = p.avatar;