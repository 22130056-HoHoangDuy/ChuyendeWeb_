-- 1. Insert 10 sản phẩm gốc vào bảng 'products'
INSERT IGNORE INTO products (id, product_name, category_id, origin, stock, size, avatar, description, embedding)
VALUES
(1, 'Giường đơn hình ô tô cho bé trai', 1, 'Việt Nam', 10, '120x200cm', 'https://res.cloudinary.com/dxz9mhmjz/image/upload/v1/giuong_oto.png', 'Giường gỗ MDF sơn không chì an toàn, thiết kế hình ô tô thể thao.', '[0.1, 0.2, 0.3]'),
(2, 'Giường cũi gỗ sồi phong cách Bắc Âu', 1, 'Việt Nam', 15, '70x140cm', 'https://res.cloudinary.com/dxz9mhmjz/image/upload/v1/cui_go.png', 'Giường cũi làm từ gỗ sồi tự nhiên, bo tròn các góc.', '[0.2, 0.1, 0.4]'),
(3, 'Bàn học chống gù thông minh', 2, 'Trung Quốc', 30, '80x60cm', 'https://res.cloudinary.com/dxz9mhmjz/image/upload/v1/ban_hoc.png', 'Bàn có thể điều chỉnh độ cao, mặt bàn chống lóa.', '[0.3, 0.4, 0.1]'),
(4, 'Ghế xoay công thái học cho bé', 2, 'Trung Quốc', 50, 'Size S', 'https://res.cloudinary.com/dxz9mhmjz/image/upload/v1/ghe_xoay.png', 'Ghế hỗ trợ cột sống, bánh xe tự khóa khi ngồi.', '[0.1, 0.5, 0.2]'),
(5, 'Đèn ngủ đám mây treo tường', 3, 'Trung Quốc', 100, '20x15cm', 'https://res.cloudinary.com/dxz9mhmjz/image/upload/v1/den_dam_may.png', 'Đèn LED dịu nhẹ, tạo không gian ấm áp cho bé.', '[0.05, 0.3, 0.1]'),
(6, 'Đèn học để bàn bảo vệ thị lực', 3, 'Việt Nam', 80, 'Cao 40cm', 'https://res.cloudinary.com/dxz9mhmjz/image/upload/v1/den_hoc.png', 'Đèn chống cận, 3 chế độ sáng điều chỉnh cảm ứng.', '[0.4, 0.2, 0.1]'),
(7, 'Ghế tựa bọc nỉ hình thú', 2, 'Việt Nam', 40, '50x50cm', 'https://res.cloudinary.com/dxz9mhmjz/image/upload/v1/ghe_thu.png', 'Ghế lười hình gấu, chất liệu nỉ nhung êm ái.', '[0.2, 0.2, 0.5]'),
(8, 'Giường tầng thông minh có cầu trượt', 1, 'Trung Quốc', 5, '140x200cm', 'https://res.cloudinary.com/dxz9mhmjz/image/upload/v1/giuong_tang.png', 'Giường tầng tích hợp cầu trượt và ngăn kéo chứa đồ.', '[0.5, 0.1, 0.2]'),
(9, 'Đèn trần mặt trăng decor', 3, 'Trung Quốc', 25, 'Đường kính 40cm', 'https://res.cloudinary.com/dxz9mhmjz/image/upload/v1/den_trang.png', 'Đèn thả trần hình mặt trăng 3D sinh động.', '[0.1, 0.6, 0.3]'),
(10, 'Bàn chơi Lego đa năng', 2, 'Việt Nam', 60, '60x60cm', 'https://res.cloudinary.com/dxz9mhmjz/image/upload/v1/ban_lego.png', 'Bàn tích hợp ngăn chứa Lego và mặt bàn vẽ tranh.', '[0.3, 0.3, 0.3]');

-- 2. Insert 10 thông tin bán hàng tương ứng vào 'seller_products'
INSERT IGNORE INTO seller_products (id, seller_id, product_id, product_name, image_url, price, stock, sku, status, created_at, updated_at)
VALUES
(1, 1, 1, 'Giường ô tô bé trai - Shop Decor', 'https://res.cloudinary.com/dxz9mhmjz/image/upload/v1/giuong_oto.png', 3500000, 5, 'SKU-001', 'ACTIVE', NOW(), NOW()),
(2, 1, 2, 'Cũi gỗ sồi Nordic - Shop Decor', 'https://res.cloudinary.com/dxz9mhmjz/image/upload/v1/cui_go.png', 2800000, 8, 'SKU-002', 'ACTIVE', NOW(), NOW()),
(3, 1, 3, 'Bàn chống gù Smart - Shop Decor', 'https://res.cloudinary.com/dxz9mhmjz/image/upload/v1/ban_hoc.png', 1900000, 15, 'SKU-003', 'ACTIVE', NOW(), NOW()),
(4, 1, 4, 'Ghế xoay học sinh - Shop Decor', 'https://res.cloudinary.com/dxz9mhmjz/image/upload/v1/ghe_xoay.png', 850000, 20, 'SKU-004', 'ACTIVE', NOW(), NOW()),
(5, 1, 5, 'Đèn ngủ mây LED - Shop Decor', 'https://res.cloudinary.com/dxz9mhmjz/image/upload/v1/den_dam_may.png', 150000, 50, 'SKU-005', 'ACTIVE', NOW(), NOW()),
(6, 1, 6, 'Đèn học chống cận - Shop Decor', 'https://res.cloudinary.com/dxz9mhmjz/image/upload/v1/den_hoc.png', 320000, 40, 'SKU-006', 'ACTIVE', NOW(), NOW()),
(7, 1, 7, 'Ghế lười hình thú - Shop Decor', 'https://res.cloudinary.com/dxz9mhmjz/image/upload/v1/ghe_thu.png', 450000, 20, 'SKU-007', 'ACTIVE', NOW(), NOW()),
(8, 1, 8, 'Giường tầng cầu trượt - Shop Decor', 'https://res.cloudinary.com/dxz9mhmjz/image/upload/v1/giuong_tang.png', 6500000, 2, 'SKU-008', 'ACTIVE', NOW(), NOW()),
(9, 1, 9, 'Đèn thả mặt trăng - Shop Decor', 'https://res.cloudinary.com/dxz9mhmjz/image/upload/v1/den_trang.png', 550000, 10, 'SKU-009', 'ACTIVE', NOW(), NOW()),
(10, 1, 10, 'Bàn Lego đa năng - Shop Decor', 'https://res.cloudinary.com/dxz9mhmjz/image/upload/v1/ban_lego.png', 950000, 30, 'SKU-010', 'ACTIVE', NOW(), NOW());