CREATE DATABASE IF NOT EXISTS pizzeria_pm02;
USE pizzeria_pm02;

CREATE TABLE IF NOT EXISTS roles (
    role_id   INT PRIMARY KEY AUTO_INCREMENT,
    role_name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS users (
    user_id      INT PRIMARY KEY AUTO_INCREMENT,
    username     VARCHAR(50) NOT NULL UNIQUE,
    password     VARCHAR(50) NOT NULL,
    full_name    VARCHAR(100),
    contact_info VARCHAR(100),
    role_id      INT,
    FOREIGN KEY (role_id) REFERENCES roles(role_id)
);

CREATE TABLE IF NOT EXISTS special_offers (
    offer_id            INT PRIMARY KEY AUTO_INCREMENT,
    name                VARCHAR(100) NOT NULL,
    discount_percentage DECIMAL(5,2) NOT NULL,
    valid_from          DATE NOT NULL,
    valid_to            DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS menu_items (
    item_id           INT PRIMARY KEY AUTO_INCREMENT,
    name              VARCHAR(100) NOT NULL,
    description       TEXT,
    manufacturer      VARCHAR(100),
    supplier          VARCHAR(100),
    price             DECIMAL(10,2) NOT NULL,
    category          VARCHAR(50),
    image             VARCHAR(200),
    offer_id          INT,
    quantity_in_stock INT DEFAULT 0,
    unit_of_measure   VARCHAR(20) DEFAULT 'шт',
    FOREIGN KEY (offer_id) REFERENCES special_offers(offer_id)
);

CREATE TABLE IF NOT EXISTS orders (
    order_id         INT PRIMARY KEY AUTO_INCREMENT,
    user_id          INT,
    article          VARCHAR(50) NOT NULL UNIQUE,
    status           VARCHAR(50) DEFAULT 'Ожидает приготовления',
    pickup_delivery  VARCHAR(200),
    order_date       DATETIME DEFAULT CURRENT_TIMESTAMP,
    delivery_date    DATETIME,
    total_amount     DECIMAL(10,2),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE IF NOT EXISTS order_items (
    id         INT PRIMARY KEY AUTO_INCREMENT,
    order_id   INT,
    item_id    INT,
    quantity   INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (item_id) REFERENCES menu_items(item_id)
);

INSERT INTO roles (role_id, role_name) VALUES 
(1, 'admin'),
(2, 'client'),
(3, 'manager');

INSERT INTO users (user_id, username, password, full_name, contact_info, role_id) VALUES 
(1, 'admin', 'admin', 'Администратор', '+7 900 000-00-00', 1),
(2, 'ivanov', 'pass123', 'Иванов Иван', '+7 911 111-11-11', 2),
(3, 'petrova', 'pass456', 'Петрова Мария', '+7 922 222-22-22', 2),
(4, 'manager', 'manager123', 'Петров Петр', '+7 933 333-33-33', 3);

INSERT INTO special_offers (offer_id, name, discount_percentage, valid_from, valid_to) VALUES 
(1, 'Весенняя акция', 10.0, '2026-01-01', '2026-12-31'),
(2, 'Летняя акция', 15.0, '2026-06-01', '2026-08-31'),
(3, 'Специальное предложение', 20.0, '2026-05-01', '2026-05-31');

INSERT INTO menu_items (name, description, manufacturer, supplier, price, category, image, offer_id, quantity_in_stock, unit_of_measure) VALUES 
('Маргарита', 'Томат, моцарелла, базилик', 'Итальянская пекарня', 'ООО ПиццаТрейд', 490.0, 'Пицца', 'Маргарита.jpg', NULL, 10, 'шт'),
('Пепперони', 'Острая колбаса, томат, сыр', 'Итальянская пекарня', 'ООО ПиццаТрейд', 540.0, 'Пицца', 'Пепперони.jpg', 1, 15, 'шт'),
('Четыре сыра', 'Моцарелла, чеддер, пармезан, рокфор', 'Итальянская пекарня', 'ООО ПиццаТрейд', 590.0, 'Пицца', 'Четыре сыра.jpg', NULL, 8, 'шт'),
('Четыре вкуса', 'Четыре разные начинки', 'Итальянская пекарня', 'ООО ПиццаТрейд', 610.0, 'Пицца', 'Четыре вкуса.jpg', 1, 12, 'шт'),
('Гавайская', 'Курица, ананас, сыр', 'Итальянская пекарня', 'ООО ПиццаТрейд', 520.0, 'Пицца', 'Гавайская.jpg', NULL, 5, 'шт'),
('Вегетарианская', 'Болгарский перец, грибы, оливки', 'Итальянская пекарня', 'ООО ПиццаТрейд', 470.0, 'Пицца', 'Вегетарианская.jpg', 1, 7, 'шт'),
('Дьябло', 'Острый перец, салями, чеснок', 'Итальянская пекарня', 'ООО ПиццаТрейд', 560.0, 'Пицца', 'Дьябло.jpg', NULL, 3, 'шт'),
('Зимняя пицца с трюфелем', 'Трюфельный соус, грибы, пармезан', 'Итальянская пекарня', 'ООО ПиццаТрейд', 890.0, 'Пицца', 'Зимняя пицца с трюфелем.jpg', 1, 2, 'шт'),
('Цезарь с курицей', 'Курица, романо, сухарики, пармезан', 'Локальная ферма', 'ООО Здоровое Питание', 320.0, 'Салат', 'Цезарь с курицей.jpg', NULL, 20, 'шт'),
('Греческий салат', 'Огурец, томат, фета, маслины', 'Локальная ферма', 'ООО Здоровое Питание', 290.0, 'Салат', 'Греческий салат.jpg', 1, 15, 'шт'),
('Летний салат с клубникой', 'Клубника, шпинат, рикотта, орехи', 'Локальная ферма', 'ООО Здоровое Питание', 340.0, 'Салат', 'Летний салат с клубникой.jpg', NULL, 10, 'шт'),
('Сырные палочки', 'Моцарелла в панировке, соус', 'Русская кухня', 'ООО ЗакускиТрейд', 250.0, 'Закуска', 'Сырные палочки.jpg', NULL, 30, 'шт'),
('Куриные крылышки BBQ', 'Крылышки в соусе барбекю', 'Русская кухня', 'ООО ЗакускиТрейд', 310.0, 'Закуска', 'Куриные крылышки BBQ.jpg', 1, 25, 'шт'),
('Тирамису', 'Маскарпоне, эспрессо, савоярди', 'Итальянская пекарня', 'ООО ДесертыТрейд', 280.0, 'Десерт', 'Тирамису.jpg', NULL, 12, 'шт'),
('Панна-котта', 'Ванильный крем, ягодный соус', 'Итальянская пекарня', 'ООО ДесертыТрейд', 260.0, 'Десерт', 'Панна-котта.jpg', NULL, 8, 'шт'),
('Кола', 'Газированный напиток', 'Coca-Cola', 'ООО НапиткиТрейд', 120.0, 'Напиток', 'cola.jpg', NULL, 50, 'шт'),
('Сок апельсиновый', 'Натуральный сок', 'Добрый', 'ООО НапиткиТрейд', 150.0, 'Напиток', 'orange_juice.jpg', NULL, 40, 'шт'),
('Чай чёрный', 'Чай в пакетике', 'Lipton', 'ООО НапиткиТрейд', 80.0, 'Напиток', 'tea.jpg', NULL, 100, 'шт');

INSERT INTO orders (order_id, user_id, article, status, pickup_delivery, order_date, delivery_date, total_amount) VALUES 
(1, 2, 'ORD-20260415-001', 'Выдан', 'ул. Пушкина, д.10', '2026-04-15 12:30:00', '2026-04-15 13:00:00', 1030.00),
(2, 3, 'ORD-20260416-002', 'Доставляется', 'ул. Ленина, д.5, кв.3', '2026-04-16 18:00:00', '2026-04-16 19:30:00', 560.00),
(3, 2, 'ORD-20260417-003', 'Ожидает приготовления', 'пр. Мира, д.15', '2026-04-17 09:15:00', '2026-04-17 11:00:00', 490.00),
(4, 2, 'ORD-20260525-004', 'Готовится', 'ул. Советская, д.20', '2026-05-25 10:00:00', '2026-05-25 12:00:00', 1500.00),
(5, 3, 'ORD-20260525-005', 'Ожидает приготовления', 'ул. Гагарина, д.8', '2026-05-25 11:30:00', '2026-05-26 11:30:00', 2800.00);

INSERT INTO order_items (order_id, item_id, quantity, unit_price) VALUES 
(1, 2, 1, 540.00),
(1, 9, 1, 320.00),
(2, 3, 1, 590.00),
(3, 1, 1, 490.00),
(4, 2, 2, 540.00),
(4, 12, 2, 250.00),
(5, 3, 2, 590.00),
(5, 4, 1, 610.00),
(5, 14, 3, 280.00);