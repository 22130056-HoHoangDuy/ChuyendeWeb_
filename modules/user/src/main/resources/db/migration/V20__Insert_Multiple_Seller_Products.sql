-- Chèn nhiều sản phẩm vào seller_products
-- Lưu ý: Kiểm tra seller_id và product_id tồn tại trước khi chạy
INSERT IGNORE INTO seller_products (
    seller_id,
    product_id,
    product_name,
    image_url,
    price,
    stock,
    sku,
    status,
    created_at,
    updated_at
) VALUES
(1, 1, 'Giường ô tô bé trai - Shop Decor', 'https://res.cloudinary.com/dxz9mhmjz/image/upload/v1/giuong_oto.png', 3500000, 10, 'SKU-AUTO-001', 'ACTIVE', NOW(), NOW()),
(1, 2, 'Cũi gỗ sồi Nordic - Shop Decor', 'https://res.cloudinary.com/dxz9mhmjz/image/upload/v1/cui_go.png', 2800000, 15, 'SKU-CUI-002', 'ACTIVE', NOW(), NOW()),
(1, 3, 'Bàn chống gù Smart - Shop Decor', 'https://res.cloudinary.com/dxz9mhmjz/image/upload/v1/ban_hoc.png', 1900000, 20, 'SKU-BAN-003', 'ACTIVE', NOW(), NOW()),
(1, 4, 'Ghế xoay học sinh - Shop Decor', 'https://res.cloudinary.com/dxz9mhmjz/image/upload/v1/ghe_xoay.png', 850000, 25, 'SKU-GHE-004', 'ACTIVE', NOW(), NOW()),
(1, 5, 'Đèn ngủ mây LED - Shop Decor', 'https://res.cloudinary.com/dxz9mhmjz/image/upload/v1/den_dam_may.png', 150000, 100, 'SKU-DEN-005', 'ACTIVE', NOW(), NOW()),
(1, 6, 'Đèn học chống cận - Shop Decor', 'https://res.cloudinary.com/dxz9mhmjz/image/upload/v1/den_hoc.png', 320000, 50, 'SKU-DEN-006', 'ACTIVE', NOW(), NOW()),
(1, 7, 'Ghế lười hình thú - Shop Decor', 'https://res.cloudinary.com/dxz9mhmjz/image/upload/v1/ghe_thu.png', 450000, 30, 'SKU-GHE-007', 'ACTIVE', NOW(), NOW()),
(1, 8, 'Giường tầng cầu trượt - Shop Decor', 'https://res.cloudinary.com/dxz9mhmjz/image/upload/v1/giuong_tang.png', 6500000, 5, 'SKU-GIUONG-008', 'ACTIVE', NOW(), NOW()),
(1, 9, 'Đèn thả mặt trăng - Shop Decor', 'https://res.cloudinary.com/dxz9mhmjz/image/upload/v1/den_trang.png', 550000, 15, 'SKU-DEN-009', 'ACTIVE', NOW(), NOW()),
(1, 10, 'Bàn Lego đa năng - Shop Decor', 'https://res.cloudinary.com/dxz9mhmjz/image/upload/v1/ban_lego.png', 950000, 40, 'SKU-BAN-010', 'ACTIVE', NOW(), NOW());