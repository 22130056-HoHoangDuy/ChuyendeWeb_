-- ==========================================
-- INSERT DATA INTO categories
-- ==========================================
INSERT INTO categories (id, name)
VALUES (1, 'Nội thất'),
       (2, 'Tranh trí tường'),
       (3, 'Đèn');
-- ==========================================
-- INSERT DATA INTO products (Category: Nội thất)
-- ==========================================
INSERT INTO products (id, product_name, category_id, origin, stock, size, avatar, note, description, embedding)
VALUES (1,
        'Giường Ngủ GN-N2 Hộp Gỗ MDF Cao Cấp',
        1,
        'Việt Nam',
        100,
        '140x200',
        'https://product.hstatic.net/1000075734/product/giuong-ngu-hien-dai-go-cong-nghiep-thiet-ke-dep-skylar-6_17fdca306e324fd1a97afcab33e5658a_master.jpg',
        NULL,
        'Giường ngủ gỗ công nghiệp hiện đại chỉ bao gồm 1 giường, không kèm các phụ kiện khác. Chất liệu: Gỗ MDF đạt tiêu chuẩn E1 nhập khẩu được phủ Melamine chống thấm. Đã qua xử lý chống cong vênh, mối mọt. Khó trầy xước , những vết xước nhẹ sẽ không ảnh hưởng đến sản phẩm.',
        NULL),

       (2,
        'Giường Ngủ GN-9260 Cho Trẻ Em',
        1,
        'Việt Nam',
        100,
        '140x200',
        'https://product.hstatic.net/1000075734/product/avar-giuong-ngu-go-mdf-cho-tre-ghs-9260-5_f51e502154f7484fbe0cd0e5c4e34561_master.jpg',
        NULL,
        'Giường Ngủ GN-9260 Cho Trẻ Em thiết kế kết hợp với ngăn tủ kéo bên dưới vô cùng tiện lợi giúp không gian phòng ngủ của bé thêm tiện nghi hơn. Sản phẩm giường ngủ được làm từ vật liệu thân thiện với môi trường, an toàn với sức khỏe bé cho bố mẹ an tâm cho con sử dụng.',
        NULL);