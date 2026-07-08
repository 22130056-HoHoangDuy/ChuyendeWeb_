-- =====================================================
-- PART 1.1
-- ROLES
-- =====================================================

INSERT INTO roles (id, role_name)
VALUES (1, 'ROLE_ADMIN'),
       (2, 'ROLE_SELLER'),
       (3, 'ROLE_CUSTOMER');
-- =====================================================
-- PART 1.2
-- USERS
-- =====================================================

INSERT INTO users
(id,
 email,
 password,
 full_name,
 avatar,
 age,
 phone,
 enabled)
VALUES

-- ===========================
-- ADMIN
-- ===========================

(1,
 'admin@childrenroom.com',
 '$2a$10$7EqJtq98hPqEX7fNZaFWoOHi5Pz9n5G8G4v7XJ6nFJkY1QzK6uY9S',
 'System Administrator',
 'https://i.pravatar.cc/300?img=1',
 30,
 '0900000001',
 TRUE),

-- ===========================
-- SELLER 1
-- ===========================

(2,
 'seller1@childrenroom.com',
 '$2a$10$7EqJtq98hPqEX7fNZaFWoOHi5Pz9n5G8G4v7XJ6nFJkY1QzK6uY9S',
 'Happy Kids Furniture',
 'https://i.pravatar.cc/300?img=12',
 28,
 '0900000002',
 TRUE),

-- ===========================
-- SELLER 2
-- ===========================

(3,
 'seller2@childrenroom.com',
 '$2a$10$7EqJtq98hPqEX7fNZaFWoOHi5Pz9n5G8G4v7XJ6nFJkY1QzK6uY9S',
 'Dream Room Decor',
 'https://i.pravatar.cc/300?img=15',
 31,
 '0900000003',
 TRUE),

-- ===========================
-- BUYER 1
-- ===========================

(4,
 'buyer1@gmail.com',
 '$2a$10$7EqJtq98hPqEX7fNZaFWoOHi5Pz9n5G8G4v7XJ6nFJkY1QzK6uY9S',
 'Nguyễn Văn An',
 'https://i.pravatar.cc/300?img=20',
 22,
 '0900000004',
 TRUE),

-- ===========================
-- BUYER 2
-- ===========================

(5,
 'buyer2@gmail.com',
 '$2a$10$7EqJtq98hPqEX7fNZaFWoOHi5Pz9n5G8G4v7XJ6nFJkY1QzK6uY9S',
 'Trần Thị Bình',
 'https://i.pravatar.cc/300?img=25',
 21,
 '0900000005',
 TRUE);
-- =====================================================
-- PART 1.3
-- USER ROLES
-- =====================================================

INSERT INTO user_roles
(user_id,
 role_id)
VALUES

-- ADMIN
(1, 1),

-- SELLER
(2, 2),
(3, 2),

-- BUYER
(4, 3),
(5, 3);
-- =====================================================
-- PART 1.4
-- WALLETS
-- =====================================================

INSERT INTO wallets
(id,
 user_id,
 balance)
VALUES (1, 1, 0.00),

       (2, 2, 1500000.00),

       (3, 3, 850000.00),

       (4, 4, 500000.00),

       (5, 5, 250000.00);
-- =====================================================
-- PART 2
-- CATEGORIES
-- =====================================================

INSERT INTO categories
(id,
 name)
VALUES (1,
        'Nội thất'),

       (2,
        'Trang trí tường'),

       (3,
        'Đèn');
-- =====================================================
-- PART 3.1
-- PRODUCTS (1 - 10)
-- =====================================================

INSERT INTO products
(id,
 product_name,
 category_id,
 origin,
 stock,
 size,
 avatar,
 description,
 embedding)
VALUES (1,
        'Giường Ngủ GN-N2 Hộp Gỗ MDF Cao Cấp',
        1,
        'Việt Nam',
        100,
        '140x200',
        'https://product.hstatic.net/1000075734/product/giuong-ngu-hien-dai-go-cong-nghiep-thiet-ke-dep-skylar-6_17fdca306e324fd1a97afcab33e5658a_master.jpg',
        'Giường ngủ gỗ công nghiệp hiện đại chỉ bao gồm 1 giường, không kèm các phụ kiện khác. Chất liệu: Gỗ MDF đạt tiêu chuẩn E1 nhập khẩu được phủ Melamine chống thấm. Đã qua xử lý chống cong vênh, mối mọt. Khó trầy xước, những vết xước nhẹ sẽ không ảnh hưởng đến sản phẩm.',
        NULL),

       (2,
        'Giường Ngủ GN-9260 Cho Trẻ Em',
        1,
        'Việt Nam',
        100,
        '140x200',
        'https://product.hstatic.net/1000075734/product/avar-giuong-ngu-go-mdf-cho-tre-ghs-9260-5_f51e502154f7484fbe0cd0e5c4e34561_master.jpg',
        'Giường ngủ thiết kế kết hợp ngăn kéo bên dưới, chất liệu thân thiện môi trường, an toàn cho trẻ.',
        NULL),

       (3,
        'Giường Cũi - Giường Ghép Cho Bé - GC003',
        1,
        'Việt Nam',
        100,
        '140x200',
        'https://cdn.hstatic.net/products/1000075734/63_206127ccf9cd464bbecf7b8d51ceb45f_grande.png',
        'Giường cũi hiện đại giúp bé có không gian ngủ an toàn và thoải mái.',
        NULL),

       (4,
        'Ghế Sofa Trẻ Em Có Thể Điều Chỉnh',
        1,
        'Trung Quốc',
        100,
        '50x50x50',
        'https://down-vn.img.susercontent.com/file/vn-11134201-7ras8-mdhvkceqgszpa4@resize_w900_nl.webp',
        'Ghế sofa mềm mại, có tựa lưng, phù hợp cho trẻ đọc sách và thư giãn.',
        NULL),

       (5,
        'Ghế gỗ mầm non ván cao su 18mm PL0111C',
        1,
        'Việt Nam',
        100,
        '32x26x55',
        'https://dochoiphulong.com/wp-content/uploads/2020/10/ghe-go-mam-non-phu-long-pl0111c-3.jpg',
        'Ghế gỗ cao su phủ sơn PU, bo tròn các góc cạnh, đảm bảo an toàn cho trẻ.',
        NULL),

       (6,
        'Ghế sofa cho bé SFD-02',
        1,
        'Việt Nam',
        100,
        '45x42x56',
        'https://bizweb.dktcdn.net/100/429/325/products/ghe-sofa-cho-be-sfd-02.jpg?v=1762134680910',
        'Ghế sofa dành riêng cho trẻ em với thiết kế đáng yêu và bền bỉ.',
        NULL),

       (7,
        'Tủ đựng quần áo cho em bé 3 buồng GHS-52232',
        1,
        'Trung Quốc',
        100,
        '950x450x1200',
        'https://gotrangtri.vn/wp-content/uploads/2024/03/avar-tu-dung-quan-ao-cho-em-be.jpg',
        'Tủ quần áo 3 buồng rộng rãi giúp bé sắp xếp quần áo ngăn nắp.',
        NULL),

       (8,
        'Tủ quần áo nhiều ngăn cho bé GHS-52216',
        1,
        'Việt Nam',
        100,
        '600x450x1400',
        'https://gotrangtri.vn/wp-content/uploads/2024/03/tu-quan-ao-nhieu-ngan-GHS-52216-3.jpg',
        'Tủ quần áo nhiều ngăn giúp tối ưu không gian lưu trữ cho phòng bé.',
        NULL),

       (9,
        'Bộ bàn ghế chống gù chống cận màu hồng BBT Global BB205',
        1,
        'Việt Nam',
        100,
        '90x60x82',
        'https://sudospaces.com/babycuatoi/2023/09/bb205-bo-ban-ghe-thong-minh-chong-gu-cho-be-tang-chong-cam-chong-nguc-24.jpg',
        'Bộ bàn ghế chống gù, chống cận với mặt bàn chống lóa và ghế điều chỉnh linh hoạt.',
        NULL),

       (10,
        'Bộ bàn ghế chống gù chống cận màu xanh BBT Global BB205',
        1,
        'Việt Nam',
        100,
        '90x60x82',
        'https://sudospaces.com/babycuatoi/2026/03/bb205-ban-hoc-chong-gu.jpg',
        'Bộ bàn ghế chống gù chống cận màu xanh với thiết kế hiện đại, phù hợp cho trẻ em.',
        NULL),
       (11,
        'Kệ sách gỗ cho bé nhiều tầng GHS-2587',
        1,
        'Việt Nam',
        100,
        '80x30x120',
        'https://gotrangtri.vn/wp-content/uploads/2024/03/ke-sach-go-cho-be-GHS-2587.jpg',
        'Kệ sách nhiều tầng giúp bé sắp xếp sách và đồ chơi gọn gàng, phù hợp phòng ngủ hoặc góc học tập.',
        NULL),

       (12,
        'Kệ đồ chơi hình ngôi nhà cho bé',
        1,
        'Việt Nam',
        100,
        '90x30x100',
        'https://bizweb.dktcdn.net/100/429/325/products/ke-do-choi-cho-be.jpg',
        'Thiết kế hình ngôi nhà dễ thương, nhiều ngăn chứa đồ chơi giúp bé rèn luyện thói quen ngăn nắp.',
        NULL),

       (13,
        'Tranh Canvas Phi Hành Gia Cho Bé',
        2,
        'Việt Nam',
        100,
        '40x60',
        'https://product.hstatic.net/1000075734/product/tranh-canvas-phi-hanh-gia.jpg',
        'Tranh canvas phong cách vũ trụ tạo điểm nhấn sinh động cho phòng trẻ em.',
        NULL),

       (14,
        'Tranh Canvas Khủng Long Hoạt Hình',
        2,
        'Việt Nam',
        100,
        '40x60',
        'https://product.hstatic.net/1000075734/product/tranh-canvas-khung-long.jpg',
        'Tranh trang trí với hình ảnh khủng long đáng yêu, phù hợp phòng bé trai.',
        NULL),

       (15,
        'Bộ 3 Tranh Treo Tường Động Vật',
        2,
        'Việt Nam',
        100,
        '30x40',
        'https://cf.shopee.vn/file/bo-3-tranh-dong-vat.jpg',
        'Bộ tranh động vật ngộ nghĩnh mang đến không gian vui tươi và gần gũi cho trẻ.',
        NULL),

       (16,
        'Đèn ngủ LED hình Mặt Trăng',
        3,
        'Trung Quốc',
        100,
        '15x15',
        'https://cf.shopee.vn/file/den-ngu-mat-trang.jpg',
        'Đèn LED ánh sáng dịu nhẹ, thích hợp làm đèn ngủ cho bé.',
        NULL),

       (17,
        'Đèn ngủ hình Gấu Panda',
        3,
        'Trung Quốc',
        100,
        '12x15',
        'https://cf.shopee.vn/file/den-gau-panda.jpg',
        'Đèn ngủ silicon mềm mại, ánh sáng ấm giúp bé ngủ ngon hơn.',
        NULL),

       (18,
        'Đèn ngủ hình Thỏ Silicon',
        3,
        'Trung Quốc',
        100,
        '13x18',
        'https://cf.shopee.vn/file/den-tho-silicon.jpg',
        'Đèn ngủ cảm ứng với thiết kế hình thỏ đáng yêu, an toàn cho trẻ nhỏ.',
        NULL),

       (19,
        'Đồng hồ treo tường hình Mây',
        2,
        'Việt Nam',
        100,
        '30x30',
        'https://cf.shopee.vn/file/dong-ho-may.jpg',
        'Đồng hồ treo tường thiết kế hình mây giúp căn phòng thêm sinh động.',
        NULL),

       (20,
        'Thảm trải sàn hoạt hình cho bé',
        1,
        'Việt Nam',
        100,
        '150x200',
        'https://cf.shopee.vn/file/tham-hoat-hinh.jpg',
        'Thảm trải sàn mềm mại, chống trơn trượt, tạo khu vui chơi an toàn cho trẻ.',
        NULL),
       (21,
        'Đèn ngủ LED hình Đám Mây',
        3,
        'Trung Quốc',
        100,
        '18x12',
        'https://cf.shopee.vn/file/den-may.jpg',
        'Đèn ngủ LED ánh sáng vàng dịu, thiết kế hình đám mây giúp tạo không gian ấm áp cho phòng bé.',
        NULL),

       (22,
        'Đèn bàn học chống cận cho bé',
        3,
        'Việt Nam',
        100,
        '35x18',
        'https://cf.shopee.vn/file/den-ban-hoc.jpg',
        'Đèn bàn LED chống chói, nhiều mức điều chỉnh ánh sáng, phù hợp cho góc học tập.',
        NULL),

       (23,
        'Giá sách mini để bàn cho bé',
        1,
        'Việt Nam',
        100,
        '45x20x35',
        'https://cf.shopee.vn/file/gia-sach-mini.jpg',
        'Giá sách nhỏ gọn giúp bé sắp xếp sách vở và đồ dùng học tập ngăn nắp.',
        NULL),

       (24,
        'Tủ đầu giường cho bé',
        1,
        'Việt Nam',
        100,
        '45x40x50',
        'https://cf.shopee.vn/file/tu-dau-giuong.jpg',
        'Tủ đầu giường nhỏ gọn với nhiều ngăn chứa tiện lợi, phù hợp phòng ngủ trẻ em.',
        NULL),

       (25,
        'Bảng treo tường học tập cho bé',
        2,
        'Việt Nam',
        100,
        '60x90',
        'https://cf.shopee.vn/file/bang-treo-tuong.jpg',
        'Bảng ghi chú treo tường giúp bé lên kế hoạch học tập và trang trí góc học tập.',
        NULL),

       (26,
        'Bộ tranh Canvas Cầu Vồng',
        2,
        'Việt Nam',
        100,
        '30x40',
        'https://cf.shopee.vn/file/tranh-cau-vong.jpg',
        'Bộ tranh canvas với hình cầu vồng và gam màu nhẹ nhàng tạo điểm nhấn cho phòng bé.',
        NULL),

       (27,
        'Đèn ngủ hình Ngôi Sao',
        3,
        'Trung Quốc',
        100,
        '15x15',
        'https://cf.shopee.vn/file/den-ngoi-sao.jpg',
        'Đèn ngủ LED hình ngôi sao với ánh sáng dịu nhẹ, thích hợp sử dụng vào ban đêm.',
        NULL),

       (28,
        'Kệ treo tường hình Mây',
        2,
        'Việt Nam',
        100,
        '60x20',
        'https://cf.shopee.vn/file/ke-treo-tuong-may.jpg',
        'Kệ treo tường thiết kế hình mây giúp tăng không gian lưu trữ và trang trí phòng bé.',
        NULL),

       (29,
        'Ghế học sinh điều chỉnh độ cao',
        1,
        'Việt Nam',
        100,
        '45x45x80',
        'https://cf.shopee.vn/file/ghe-hoc-sinh.jpg',
        'Ghế học tập có thể điều chỉnh chiều cao theo sự phát triển của trẻ.',
        NULL),

       (30,
        'Đèn ngủ cảm ứng hình Mèo',
        3,
        'Trung Quốc',
        100,
        '14x16',
        'https://cf.shopee.vn/file/den-meo.jpg',
        'Đèn ngủ silicon hình mèo dễ thương, cảm ứng chạm, ánh sáng dịu và an toàn cho trẻ nhỏ.',
        NULL);

-- =====================================================
-- PART 4.1
-- SELLER PRODUCTS
-- SELLER 1 (Happy Kids Furniture)
-- PRODUCTS (1 - 6)
-- =====================================================

INSERT INTO seller_products
(id,
 seller_id,
 product_id,
 product_name,
 image_url,
 price,
 stock,
 sku,
 status)
VALUES (1,
        2,
        1,
        'Giường Ngủ GN-N2 Hộp Gỗ MDF Cao Cấp',
        'https://product.hstatic.net/1000075734/product/giuong-ngu-hien-dai-go-cong-nghiep-thiet-ke-dep-skylar-6_17fdca306e324fd1a97afcab33e5658a_master.jpg',
        5490000,
        35,
        'HKF-BED-001',
        'ACTIVE'),

       (2,
        2,
        2,
        'Giường Ngủ GN-9260 Cho Trẻ Em',
        'https://product.hstatic.net/1000075734/product/avar-giuong-ngu-go-mdf-cho-tre-ghs-9260-5_f51e502154f7484fbe0cd0e5c4e34561_master.jpg',
        4790000,
        28,
        'HKF-BED-002',
        'ACTIVE'),

       (3,
        2,
        3,
        'Giường Cũi - Giường Ghép Cho Bé - GC003',
        'https://cdn.hstatic.net/products/1000075734/63_206127ccf9cd464bbecf7b8d51ceb45f_grande.png',
        3290000,
        42,
        'HKF-BED-003',
        'ACTIVE'),

       (4,
        2,
        4,
        'Ghế Sofa Trẻ Em Có Thể Điều Chỉnh',
        'https://down-vn.img.susercontent.com/file/vn-11134201-7ras8-mdhvkceqgszpa4@resize_w900_nl.webp',
        1290000,
        18,
        'HKF-SOFA-001',
        'ACTIVE'),

       (5,
        2,
        5,
        'Ghế gỗ mầm non ván cao su 18mm PL0111C',
        'https://dochoiphulong.com/wp-content/uploads/2020/10/ghe-go-mam-non-phu-long-pl0111c-3.jpg',
        690000,
        65,
        'HKF-CHAIR-001',
        'ACTIVE'),

       (6,
        2,
        6,
        'Ghế sofa cho bé SFD-02',
        'https://bizweb.dktcdn.net/100/429/325/products/ghe-sofa-cho-be-sfd-02.jpg?v=1762134680910',
        990000,
        0,
        'HKF-SOFA-002',
        'ACTIVE'),
       (7,
        2,
        7,
        'Tủ đựng quần áo cho em bé 3 buồng GHS-52232',
        'https://gotrangtri.vn/wp-content/uploads/2024/03/avar-tu-dung-quan-ao-cho-em-be.jpg',
        3890000,
        24,
        'HKF-CABINET-001',
        'ACTIVE'),

       (8,
        2,
        8,
        'Tủ quần áo nhiều ngăn cho bé GHS-52216',
        'https://gotrangtri.vn/wp-content/uploads/2024/03/tu-quan-ao-nhieu-ngan-GHS-52216-3.jpg',
        3490000,
        31,
        'HKF-CABINET-002',
        'ACTIVE'),

       (9,
        2,
        9,
        'Bộ bàn ghế chống gù chống cận màu hồng BBT Global BB205',
        'https://sudospaces.com/babycuatoi/2023/09/bb205-bo-ban-ghe-thong-minh-chong-gu-cho-be-tang-chong-cam-chong-nguc-24.jpg',
        2890000,
        27,
        'HKF-DESK-001',
        'ACTIVE'),

       (10,
        2,
        10,
        'Bộ bàn ghế chống gù chống cận màu xanh BBT Global BB205',
        'https://sudospaces.com/babycuatoi/2026/03/bb205-ban-hoc-chong-gu.jpg',
        2890000,
        15,
        'HKF-DESK-002',
        'ACTIVE'),

       (11,
        2,
        11,
        'Kệ sách gỗ cho bé nhiều tầng GHS-2587',
        'https://gotrangtri.vn/wp-content/uploads/2024/03/ke-sach-go-cho-be-GHS-2587.jpg',
        1490000,
        43,
        'HKF-BOOK-001',
        'ACTIVE'),

       (12,
        2,
        12,
        'Kệ đồ chơi hình ngôi nhà cho bé',
        'https://bizweb.dktcdn.net/100/429/325/products/ke-do-choi-cho-be.jpg',
        1190000,
        38,
        'HKF-BOOK-002',
        'ACTIVE'),

       (13,
        3,
        13,
        'Tranh Canvas Phi Hành Gia Cho Bé',
        'https://product.hstatic.net/1000075734/product/tranh-canvas-phi-hanh-gia.jpg',
        399000,
        48,
        'DRD-WALL-001',
        'ACTIVE'),

       (14,
        3,
        14,
        'Tranh Canvas Khủng Long Hoạt Hình',
        'https://product.hstatic.net/1000075734/product/tranh-canvas-khung-long.jpg',
        429000,
        36,
        'DRD-WALL-002',
        'ACTIVE'),

       (15,
        3,
        15,
        'Bộ 3 Tranh Treo Tường Động Vật',
        'https://cf.shopee.vn/file/bo-3-tranh-dong-vat.jpg',
        599000,
        22,
        'DRD-WALL-003',
        'ACTIVE'),

       (16,
        3,
        16,
        'Đèn ngủ LED hình Mặt Trăng',
        'https://cf.shopee.vn/file/den-ngu-mat-trang.jpg',
        349000,
        57,
        'DRD-LAMP-001',
        'ACTIVE'),

       (17,
        3,
        17,
        'Đèn ngủ hình Gấu Panda',
        'https://cf.shopee.vn/file/den-gau-panda.jpg',
        289000,
        45,
        'DRD-LAMP-002',
        'ACTIVE'),

       (18,
        3,
        18,
        'Đèn ngủ hình Thỏ Silicon',
        'https://cf.shopee.vn/file/den-tho-silicon.jpg',
        319000,
        39,
        'DRD-LAMP-003',
        'ACTIVE'),

       (19,
        3,
        19,
        'Đồng hồ treo tường hình Mây',
        'https://cf.shopee.vn/file/dong-ho-may.jpg',
        459000,
        0,
        'DRD-DECO-001',
        'ACTIVE'),

       (20,
        3,
        20,
        'Thảm trải sàn hoạt hình cho bé',
        'https://cf.shopee.vn/file/tham-hoat-hinh.jpg',
        690000,
        26,
        'DRD-DECO-002',
        'ACTIVE'),

       (21,
        3,
        21,
        'Đèn ngủ LED hình Đám Mây',
        'https://cf.shopee.vn/file/den-may.jpg',
        369000,
        41,
        'DRD-LAMP-004',
        'ACTIVE'),

       (22,
        3,
        22,
        'Đèn bàn học chống cận cho bé',
        'https://cf.shopee.vn/file/den-ban-hoc.jpg',
        890000,
        18,
        'DRD-LAMP-005',
        'ACTIVE'),

       (23,
        3,
        23,
        'Giá sách mini để bàn cho bé',
        'https://cf.shopee.vn/file/gia-sach-mini.jpg',
        590000,
        30,
        'DRD-DECO-003',
        'ACTIVE'),

       (24,
        3,
        24,
        'Tủ đầu giường cho bé',
        'https://cf.shopee.vn/file/tu-dau-giuong.jpg',
        1190000,
        16,
        'DRD-DECO-004',
        'ACTIVE'),

       (25,
        3,
        25,
        'Bảng treo tường học tập cho bé',
        'https://cf.shopee.vn/file/bang-treo-tuong.jpg',
        490000,
        42,
        'DRD-WALL-004',
        'ACTIVE'),

       (26,
        3,
        26,
        'Bộ tranh Canvas Cầu Vồng',
        'https://cf.shopee.vn/file/tranh-cau-vong.jpg',
        359000,
        37,
        'DRD-WALL-005',
        'ACTIVE'),

       (27,
        3,
        27,
        'Đèn ngủ hình Ngôi Sao',
        'https://cf.shopee.vn/file/den-ngoi-sao.jpg',
        329000,
        24,
        'DRD-LAMP-006',
        'ACTIVE'),

       (28,
        3,
        28,
        'Kệ treo tường hình Mây',
        'https://cf.shopee.vn/file/ke-treo-tuong-may.jpg',
        649000,
        20,
        'DRD-DECO-005',
        'ACTIVE'),

       (29,
        3,
        29,
        'Ghế học sinh điều chỉnh độ cao',
        'https://cf.shopee.vn/file/ghe-hoc-sinh.jpg',
        1590000,
        12,
        'DRD-DECO-006',
        'ACTIVE'),

       (30,
        3,
        30,
        'Đèn ngủ cảm ứng hình Mèo',
        'https://cf.shopee.vn/file/den-meo.jpg',
        389000,
        35,
        'DRD-LAMP-007',
        'ACTIVE');

-- =====================================================
-- PART 5.1
-- ORDERS
-- =====================================================

INSERT INTO orders
(id,
 user_id,
 seller_id,
 order_status,
 shipping_address,
 total_price)
VALUES (1,
        4,
        2,
        'DELIVERED',
        'Ký túc xá Đại học Nông Lâm TP.HCM',
        6870000),

       (2,
        4,
        3,
        'PROCESSING',
        'Ký túc xá Đại học Nông Lâm TP.HCM',
        948000),

       (3,
        5,
        3,
        'PENDING',
        'Linh Trung, Thủ Đức, TP.HCM',
        1279000),

       (4,
        5,
        2,
        'CANCELLED',
        'Linh Trung, Thủ Đức, TP.HCM',
        2890000);
-- =====================================================
-- PART 5.2
-- ORDER ITEMS
-- =====================================================

INSERT INTO order_items
(id,
 order_id,
 seller_product_id,
 quantity,
 price)
VALUES

-- =====================================================
-- ORDER 1 (DELIVERED)
-- Buyer 1 mua từ Happy Kids Furniture
-- =====================================================

(1,
 1,
 1,
 1,
 5490000),

(2,
 1,
 5,
 2,
 690000),

-- =====================================================
-- ORDER 2 (PROCESSING)
-- Buyer 1 mua từ Dream Room Decor
-- =====================================================

(3,
 2,
 16,
 1,
 349000),

(4,
 2,
 15,
 1,
 599000),

-- =====================================================
-- ORDER 3 (PENDING)
-- Buyer 2 mua từ Dream Room Decor
-- =====================================================

(5,
 3,
 22,
 1,
 890000),

(6,
 3,
 30,
 1,
 389000),

-- =====================================================
-- ORDER 4 (CANCELLED)
-- Buyer 2 mua từ Happy Kids Furniture
-- =====================================================

(7,
 4,
 9,
 1,
 2890000);
-- =====================================================
-- PART 5.3
-- REVIEWS
-- =====================================================
INSERT INTO reviews
(id,
 product_id,
 user_id,
 order_item_id,
 rating,
 comment)
VALUES (1,
        1,
        4,
        1,
        5,
        'Giường rất chắc chắn, hoàn thiện đẹp, bé nhà mình rất thích. Giao hàng đúng hẹn và lắp đặt cẩn thận.'),
       (2,
        5,
        4,
        2,
        4,
        'Ghế gỗ đẹp, chất lượng tốt, phù hợp với trẻ nhỏ. Giá hợp lý, sẽ tiếp tục ủng hộ.');
-- =====================================================
-- PART 5.4
-- CARTS
-- =====================================================

INSERT INTO carts
(id,
 user_id)
VALUES (1,
        4),

       (2,
        5);
-- =====================================================
-- PART 5.5
-- CART ITEMS
-- =====================================================

INSERT INTO cart_items
(id,
 cart_id,
 seller_product_id,
 quantity)
VALUES

-- =====================================================
-- BUYER 1
-- =====================================================

(1,
 1,
 11,
 1),

(2,
 1,
 13,
 2),

-- =====================================================
-- BUYER 2
-- =====================================================

(3,
 2,
 27,
 1),

(4,
 2,
 28,
 1);
-- =====================================================
-- PART 5.6
-- WISHLIST
-- =====================================================

INSERT INTO wishlist
(id,
 user_id,
 seller_product_id)
VALUES

-- =====================================================
-- BUYER 1
-- =====================================================

(1,
 4,
 2),

(2,
 4,
 12),

(3,
 4,
 21),

-- =====================================================
-- BUYER 2
-- =====================================================

(4,
 5,
 4),

(5,
 5,
 26);
-- =====================================================
-- PART 5.7
-- NOTIFICATIONS
-- =====================================================

INSERT INTO notifications
(id,
 user_id,
 title,
 message,
 type,
 is_read)
VALUES

-- =====================================================
-- ADMIN
-- =====================================================

(1,
 1,
 'Hệ thống khởi tạo thành công',
 'Dữ liệu mẫu của hệ thống Kids Room Store đã được khởi tạo thành công.',
 'SYSTEM',
 TRUE),

-- =====================================================
-- BUYER 1
-- =====================================================

(2,
 4,
 'Đơn hàng đã giao',
 'Đơn hàng #1 đã được giao thành công. Cảm ơn bạn đã mua sắm tại Kids Room Store.',
 'ORDER_COMPLETED',
 FALSE),

(3,
 4,
 'Thanh toán thành công',
 'Thanh toán cho đơn hàng #1 đã được xác nhận.',
 'PAYMENT_SUCCESS',
 TRUE),

(4,
 4,
 'Đơn hàng đang xử lý',
 'Đơn hàng #2 đang được người bán chuẩn bị.',
 'ORDER_CONFIRMED',
 FALSE),

-- =====================================================
-- BUYER 2
-- =====================================================

(5,
 5,
 'Đơn hàng đang chờ xác nhận',
 'Đơn hàng #3 đã được ghi nhận và đang chờ người bán xác nhận.',
 'ORDER_CREATED',
 FALSE),

(6,
 5,
 'Đơn hàng đã hủy',
 'Đơn hàng #4 đã được hủy theo yêu cầu.',
 'SYSTEM',
 TRUE),

-- =====================================================
-- SELLER 1
-- =====================================================

(7,
 2,
 'Bạn có đơn hàng mới',
 'Bạn vừa nhận được đơn hàng #1 từ khách hàng Nguyễn Văn An.',
 'ORDER_CREATED',
 FALSE),

(8,
 2,
 'Khách hàng vừa đánh giá sản phẩm',
 'Giường Ngủ GN-N2 Hộp Gỗ MDF Cao Cấp vừa nhận đánh giá 5 sao.',
 'SYSTEM',
 FALSE),

-- =====================================================
-- SELLER 2
-- =====================================================

(9,
 3,
 'Bạn có đơn hàng mới',
 'Bạn vừa nhận được đơn hàng #2.',
 'ORDER_CREATED',
 FALSE),

(10,
 3,
 'Đơn hàng đang được xử lý',
 'Đơn hàng #2 đã được chuyển sang trạng thái PROCESSING.',
 'ORDER_CONFIRMED',
 TRUE);