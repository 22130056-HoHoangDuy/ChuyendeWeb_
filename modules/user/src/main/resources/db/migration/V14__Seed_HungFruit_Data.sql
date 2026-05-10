-- =============================================
-- V13__Seed_HungFruit_Data.sql
-- Seed dữ liệu Hùng Fruit - An toàn, không trùng ID
-- =============================================

-- =============================================
-- 1. TẠO USER HÙNG FRUIT (Seller)
-- =============================================
INSERT IGNORE INTO users (id, email, full_name, enabled, phone, created_at)
VALUES (1, 'hungfruit.shop@gmail.com', 'Hùng Fruit - Trái Cây Sạch', TRUE, '0987654321', NOW());

INSERT IGNORE INTO user_roles (user_id, role_id)
VALUES (1, 2);  -- 2 = ROLE_SELLER

-- =============================================
-- 2. TẠO DANH MỤC (Categories)
-- =============================================
INSERT IGNORE INTO categories (id, name) VALUES
    (1, 'Trái cây Việt Nam'),
    (2, 'Trái cây nhập khẩu'),
    (3, 'Hạt & Combo');

-- =============================================
-- 3. XÓA DỮ LIỆU CŨ CỦA HÙNG FRUIT (tránh trùng)
-- =============================================
DELETE FROM seller_products WHERE seller_id = 1;
DELETE FROM products
WHERE product_name IN (
                       'Xoài Cát Hòa Lộc', 'Sầu Riêng Musang King', 'Vú Sữa Lò Rèn', 'Bưởi Da Xanh',
                       'Thanh Long Ruột Đỏ', 'Măng Cụt', 'Nhãn Xuồng Cơm Vàng', 'Táo Envy Mỹ',
                       'Nho Mẫu Đơn', 'Kiwi Vàng', 'Cherry Đỏ', 'Dâu Tây Đà Lạt', 'Cam Sành',
                       'Quýt Đường', 'Hồng Giòn', 'Combo Giỏ Quà Tết', 'Combo Trái Cây Giải Nhiệt',
                       'Hạt Dẻ Cười', 'Hạt Điều Rang Muối', 'Hạnh Nhân Rang Bơ', 'Mắc Ca Nguyên Vỏ',
                       'Mận Hậu', 'Vải Thiều', 'Dưa Lưới Taki', 'Việt Quất', 'Na Chi Lăng',
                       'Ổi Nữ Hoàng', 'Dừa Xiêm Bến Tre', 'Sapoche (Hồng Xiêm)', 'Chôm Chôm Nhãn'
    );

-- =============================================
-- 4. INSERT SẢN PHẨM (Products)
-- =============================================
INSERT INTO products (product_name, category_id, origin, stock, avatar, description) VALUES
                                                                                         ('Xoài Cát Hòa Lộc', 1, 'Tiền Giang', 200, 'https://bit.ly/xoai-cat-hl', 'Xoài Cát Hòa Lộc ngon nhất Việt Nam, ngọt lịm'),
                                                                                         ('Sầu Riêng Musang King', 2, 'Malaysia', 50, 'https://bit.ly/sau-rieng-mk', 'Sầu riêng Musang King cao cấp Malaysia'),
                                                                                         ('Vú Sữa Lò Rèn', 1, 'Vĩnh Kim', 150, 'https://bit.ly/vu-sua-lr', 'Vú sữa Lò Rèn nổi tiếng Tiền Giang'),
                                                                                         ('Bưởi Da Xanh', 1, 'Bến Tre', 100, 'https://bit.ly/buoi-dx', 'Bưởi da xanh ruột hồng ngọt mát'),
                                                                                         ('Thanh Long Ruột Đỏ', 1, 'Bình Thuận', 300, 'https://bit.ly/thanh-long-rd', 'Thanh long ruột đỏ Bình Thuận'),
                                                                                         ('Măng Cụt', 1, 'Lái Thiêu', 80, 'https://bit.ly/mang-cut-lt', 'Măng cụt Lái Thiêu chất lượng cao'),
                                                                                         ('Nhãn Xuồng Cơm Vàng', 1, 'Vũng Tàu', 120, 'https://bit.ly/nhan-xuong', 'Nhãn xuồng cơm vàng siêu ngọt'),
                                                                                         ('Táo Envy Mỹ', 2, 'USA', 60, 'https://bit.ly/tao-envy', 'Táo Envy Mỹ giòn ngọt'),
                                                                                         ('Nho Mẫu Đơn', 2, 'Nhật Bản', 30, 'https://bit.ly/nho-mau-don', 'Nho Mẫu Đơn Nhật Bản cao cấp'),
                                                                                         ('Kiwi Vàng', 2, 'New Zealand', 90, 'https://bit.ly/kiwi-vang', 'Kiwi vàng New Zealand'),
                                                                                         ('Cherry Đỏ', 2, 'Úc', 40, 'https://bit.ly/cherry-au', 'Cherry đỏ Úc tươi ngon'),
                                                                                         ('Dâu Tây Đà Lạt', 1, 'Lâm Đồng', 150, 'https://bit.ly/dau-tay-dl', 'Dâu Tây Đà Lạt sạch organic'),
                                                                                         ('Cam Sành', 1, 'Hàm Yên', 250, 'https://bit.ly/cam-sanh', 'Cam sành Hàm Yên Tuyên Quang'),
                                                                                         ('Quýt Đường', 1, 'Trà Vinh', 180, 'https://bit.ly/quyt-duong', 'Quýt đường Trà Vinh ngọt lịm'),
                                                                                         ('Hồng Giòn', 1, 'Đà Lạt', 100, 'https://bit.ly/hong-gion', 'Hồng giòn Đà Lạt'),
                                                                                         ('Combo Giỏ Quà Tết', 3, 'Hùng Fruit', 20, 'https://bit.ly/gio-qua-1', 'Giỏ quà trái cây Tết cao cấp'),
                                                                                         ('Combo Trái Cây Giải Nhiệt', 3, 'Hùng Fruit', 80, 'https://bit.ly/combo-nhiet', 'Combo trái cây giải nhiệt'),
                                                                                         ('Hạt Dẻ Cười', 3, 'Mỹ', 70, 'https://bit.ly/hat-de-cuoi', 'Hạt dẻ cười Mỹ rang giòn'),
                                                                                         ('Hạt Điều Rang Muối', 3, 'Bình Phước', 100, 'https://bit.ly/hat-dieu-bp', 'Hạt điều Bình Phước'),
                                                                                         ('Hạnh Nhân Rang Bơ', 3, 'California', 85, 'https://bit.ly/hanh-nhan', 'Hạnh nhân rang bơ Mỹ'),
                                                                                         ('Mắc Ca Nguyên Vỏ', 3, 'Đắk Lắk', 60, 'https://bit.ly/mac-ca-dl', 'Mắc ca nguyên vỏ Đắk Lắk'),
                                                                                         ('Mận Hậu', 1, 'Sơn La', 200, 'https://bit.ly/man-hau', 'Mận hậu Sơn La'),
                                                                                         ('Vải Thiều', 1, 'Bắc Giang', 150, 'https://bit.ly/vai-thieu', 'Vải thiều Lục Ngạn Bắc Giang'),
                                                                                         ('Dưa Lưới Taki', 2, 'Nhật Bản', 70, 'https://bit.ly/dua-luoi-taki', 'Dưa lưới Taki Nhật Bản'),
                                                                                         ('Việt Quất', 2, 'Peru', 90, 'https://bit.ly/viet-quat-peru', 'Việt quất Peru'),
                                                                                         ('Na Chi Lăng', 1, 'Lạng Sơn', 110, 'https://bit.ly/na-chi-lang', 'Na Chi Lăng Lạng Sơn'),
                                                                                         ('Ổi Nữ Hoàng', 1, 'Miền Tây', 300, 'https://bit.ly/oi-nu-hoang', 'Ổi nữ hoàng ruột đỏ'),
                                                                                         ('Dừa Xiêm Bến Tre', 1, 'Bến Tre', 400, 'https://bit.ly/dua-xiem', 'Dừa xiêm Bến Tre'),
                                                                                         ('Sapoche (Hồng Xiêm)', 1, 'Tiền Giang', 130, 'https://bit.ly/sapoche', 'Sapoche Hồng Xiêm'),
                                                                                         ('Chôm Chôm Nhãn', 1, 'Đồng Nai', 160, 'https://bit.ly/chom-chom', 'Chôm chôm nhãn Đồng Nai');

-- =============================================
-- 5. INSERT seller_products (Quan trọng nhất)
-- =============================================
INSERT INTO seller_products (seller_id, product_id, price, stock, status)
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
        END as price,
    CASE
        WHEN p.product_name LIKE '%Combo%' THEN 20
        WHEN p.product_name LIKE '%Sầu Riêng%' OR p.product_name LIKE '%Nho%' THEN 30
        WHEN p.product_name LIKE '%Cherry%' THEN 40
        ELSE 100
        END as stock,
    'ACTIVE'
FROM products p
WHERE p.product_name IN (
                         'Xoài Cát Hòa Lộc','Sầu Riêng Musang King','Vú Sữa Lò Rèn','Bưởi Da Xanh',
                         'Thanh Long Ruột Đỏ','Măng Cụt','Nhãn Xuồng Cơm Vàng','Táo Envy Mỹ',
                         'Nho Mẫu Đơn','Kiwi Vàng','Cherry Đỏ','Dâu Tây Đà Lạt','Cam Sành',
                         'Quýt Đường','Hồng Giòn','Combo Giỏ Quà Tết','Combo Trái Cây Giải Nhiệt',
                         'Hạt Dẻ Cười','Hạt Điều Rang Muối','Hạnh Nhân Rang Bơ','Mắc Ca Nguyên Vỏ',
                         'Mận Hậu','Vải Thiều','Dưa Lưới Taki','Việt Quất','Na Chi Lăng',
                         'Ổi Nữ Hoàng','Dừa Xiêm Bến Tre','Sapoche (Hồng Xiêm)','Chôm Chôm Nhãn'
    );

-- =============================================
-- Kiểm tra kết quả
-- =============================================
SELECT '✅ User Hùng Fruit' as thong_bao, id, full_name FROM users WHERE id = 1;
SELECT '✅ Số category' as thong_bao, COUNT(*) FROM categories;
SELECT '✅ Số sản phẩm' as thong_bao, COUNT(*) FROM products;
SELECT '✅ Số seller_products' as thong_bao, COUNT(*) FROM seller_products WHERE seller_id = 1;