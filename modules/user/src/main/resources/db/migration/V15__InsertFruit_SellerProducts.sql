-- =============================================
-- V15__Insert_HungFruit_SellerProducts.sql
-- Insert dữ liệu seller_products cho Hùng Fruit
-- =============================================

-- =============================================
-- 1. ĐẢM BẢO USER HÙNG FRUIT (seller_id = 1) TỒN TẠI
-- =============================================
INSERT IGNORE INTO users (id, email, full_name, enabled, phone, created_at)
VALUES (1, 'hungfruit.shop@gmail.com', 'Hùng Fruit - Trái Cây Sạch', TRUE, '0987654321', NOW());

INSERT IGNORE INTO user_roles (user_id, role_id) VALUES (1, 2); -- ROLE_SELLER

-- =============================================
-- 2. ĐẢM BẢO DANH MỤC TỒN TẠI
-- =============================================
INSERT IGNORE INTO categories (id, name) VALUES
    (1, 'Trái cây Việt Nam'),
    (2, 'Trái cây nhập khẩu'),
    (3, 'Hạt & Combo');

-- =============================================
-- 3. XÓA DỮ LIỆU CŨ CỦA HÙNG FRUIT ĐỂ TRÁNH TRÙNG
-- =============================================
DELETE FROM seller_products WHERE seller_id = 1;

-- =============================================
-- 4. INSERT SELLER_PRODUCTS (Phiên bản an toàn nhất)
-- =============================================
INSERT INTO seller_products
(seller_id, product_id, price, stock, status, created_at)
SELECT
    1,
    p.id,
    CASE p.product_name
        WHEN 'Xoài Cát Hòa Lộc'           THEN 65000
        WHEN 'Sầu Riêng Musang King'      THEN 450000
        WHEN 'Vú Sữa Lò Rèn'              THEN 45000
        WHEN 'Bưởi Da Xanh'               THEN 80000
        WHEN 'Thanh Long Ruột Đỏ'         THEN 35000
        WHEN 'Măng Cụt'                   THEN 75000
        WHEN 'Nhãn Xuồng Cơm Vàng'        THEN 55000
        WHEN 'Táo Envy Mỹ'                THEN 150000
        WHEN 'Nho Mẫu Đơn'                THEN 850000
        WHEN 'Kiwi Vàng'                  THEN 120000
        WHEN 'Cherry Đỏ'                  THEN 450000
        WHEN 'Dâu Tây Đà Lạt'             THEN 220000
        WHEN 'Cam Sành'                   THEN 25000
        WHEN 'Quýt Đường'                 THEN 40000
        WHEN 'Hồng Giòn'                  THEN 60000
        WHEN 'Combo Giỏ Quà Tết'          THEN 1200000
        WHEN 'Combo Trái Cây Giải Nhiệt'  THEN 350000
        WHEN 'Hạt Dẻ Cười'                THEN 320000
        WHEN 'Hạt Điều Rang Muối'         THEN 280000
        WHEN 'Hạnh Nhân Rang Bơ'          THEN 300000
        WHEN 'Mắc Ca Nguyên Vỏ'           THEN 250000
        WHEN 'Mận Hậu'                    THEN 45000
        WHEN 'Vải Thiều'                  THEN 35000
        WHEN 'Dưa Lưới Taki'              THEN 180000
        WHEN 'Việt Quất'                  THEN 95000
        WHEN 'Na Chi Lăng'                THEN 65000
        WHEN 'Ổi Nữ Hoàng'                THEN 20000
        WHEN 'Dừa Xiêm Bến Tre'           THEN 15000
        WHEN 'Sapoche (Hồng Xiêm)'        THEN 40000
        WHEN 'Chôm Chôm Nhãn'             THEN 35000
        ELSE 50000
        END AS price,
    CASE
        WHEN p.product_name LIKE '%Combo%' THEN 20
        WHEN p.product_name LIKE '%Sầu Riêng%' OR p.product_name LIKE '%Nho Mẫu Đơn%' THEN 30
        WHEN p.product_name LIKE '%Cherry%' THEN 40
        ELSE 100
        END AS stock,
    'ACTIVE',
    NOW()
FROM products p
WHERE p.product_name IN (
                         'Xoài Cát Hòa Lộc','Sầu Riêng Musang King','Vú Sữa Lò Rèn','Bưởi Da Xanh',
                         'Thanh Long Ruột Đỏ','Măng Cụt','Nhãn Xuồng Cơm Vàng','Táo Envy Mỹ',
                         'Nho Mẫu Đơn','Kiwi Vàng','Cherry Đỏ','Dâu Tây Đà Lạt','Cam Sành',
                         'Quýt Đường','Hồng Giòn','Combo Giỏ Quà Tết','Combo Trái Cây Giải Nhiệt',
                         'Hạt Dẻ Cười','Hạt Điều Rang Muối','Hạnh Nhân Rang Bơ','Mắc Ca Nguyên Vỏ',
                         'Mận Hậu','Vải Thiều','Dưa Lưới Taki','Việt Quất','Na Chi Lăng',
                         'Ổi Nữ Hoàng','Dừa Xiêm Bến Tre','Sapoche (Hồng Xiêm)','Chôm Chôm Nhãn'
    )
  AND NOT EXISTS (
    SELECT 1 FROM seller_products sp
    WHERE sp.seller_id = 1 AND sp.product_id = p.id
);

-- =============================================
-- KIỂM TRA KẾT QUẢ
-- =============================================
SELECT '✅ HOÀN TẤT V15 - Hùng Fruit Seller Products' as thong_bao;
SELECT 'Số seller_products của Hùng Fruit' as thong_bao, COUNT(*) as total
FROM seller_products WHERE seller_id = 1;

SELECT
    p.product_name,
    sp.price,
    sp.stock,
    sp.status
FROM seller_products sp
         JOIN products p ON sp.product_id = p.id
WHERE sp.seller_id = 1
ORDER BY p.product_name
LIMIT 10;