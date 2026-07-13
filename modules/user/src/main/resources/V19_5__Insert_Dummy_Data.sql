-- Chèn user mẫu có ID 1
INSERT INTO users (id, username, email) VALUES (1, 'admin', 'levuhung678@gmail.com');

-- Nếu có bảng sellers, cần chèn seller có ID 1
INSERT INTO sellers (id, user_id, shop_name) VALUES (1, 1, 'Hùng shop');