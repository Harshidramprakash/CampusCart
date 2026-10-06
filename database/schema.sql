-- ============================================================
-- CIT CampusCart – Database Schema
-- 23CS523 Web Technology Laboratory
-- ============================================================

CREATE DATABASE IF NOT EXISTS campuscart_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE campuscart_db;

-- ============================================================
-- USERS TABLE
-- ============================================================
CREATE TABLE IF NOT EXISTS users (
    user_id      INT AUTO_INCREMENT PRIMARY KEY,
    full_name    VARCHAR(100) NOT NULL,
    email        VARCHAR(150) NOT NULL UNIQUE,
    password     VARCHAR(255) NOT NULL,
    phone        VARCHAR(15),
    address      TEXT,
    role         ENUM('student', 'admin') DEFAULT 'student',
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ============================================================
-- PRODUCTS TABLE
-- ============================================================
CREATE TABLE IF NOT EXISTS products (
    product_id   INT AUTO_INCREMENT PRIMARY KEY,
    name         VARCHAR(200) NOT NULL,
    description  TEXT,
    price        DECIMAL(10,2) NOT NULL,
    category     VARCHAR(100),
    image_url    VARCHAR(500),
    stock        INT NOT NULL DEFAULT 0,
    seller_id    INT,
    is_active    BOOLEAN DEFAULT TRUE,
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (seller_id) REFERENCES users(user_id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- ============================================================
-- CART TABLE
-- ============================================================
CREATE TABLE IF NOT EXISTS cart (
    cart_id      INT AUTO_INCREMENT PRIMARY KEY,
    user_id      INT NOT NULL,
    product_id   INT NOT NULL,
    quantity     INT NOT NULL DEFAULT 1,
    added_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id)    REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_product (user_id, product_id)
) ENGINE=InnoDB;

-- ============================================================
-- ORDERS TABLE
-- ============================================================
CREATE TABLE IF NOT EXISTS orders (
    order_id        INT AUTO_INCREMENT PRIMARY KEY,
    user_id         INT NOT NULL,
    total_amount    DECIMAL(10,2) NOT NULL,
    shipping_address TEXT NOT NULL,
    payment_method  VARCHAR(50) DEFAULT 'Cash on Delivery',
    status          ENUM('pending','confirmed','shipped','delivered','cancelled') DEFAULT 'pending',
    order_date      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ============================================================
-- ORDER ITEMS TABLE
-- ============================================================
CREATE TABLE IF NOT EXISTS order_items (
    item_id       INT AUTO_INCREMENT PRIMARY KEY,
    order_id      INT NOT NULL,
    product_id    INT NOT NULL,
    quantity      INT NOT NULL,
    unit_price    DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id)   REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ============================================================
-- DEFAULT ADMIN USER
-- Password: admin123 (SHA-256 hash)
-- ============================================================
INSERT INTO users (full_name, email, password, phone, role)
VALUES ('Campus Admin', 'admin@campuscart.com',
        'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f',
        '9876543210', 'admin')
ON DUPLICATE KEY UPDATE full_name = full_name;

-- ============================================================
-- SAMPLE PRODUCTS
-- ============================================================
INSERT INTO products (name, description, price, category, image_url, stock, seller_id) VALUES
('Engineering Mathematics Textbook', 'Comprehensive textbook covering calculus, linear algebra, and differential equations. Essential for first-year engineering students.', 450.00, 'Books', 'https://placehold.co/400x400/2563eb/ffffff?text=Math+Book', 25, 1),
('Scientific Calculator (Casio fx-991EX)', 'Advanced scientific calculator with spreadsheet functionality. Permitted in university examinations.', 1350.00, 'Electronics', 'https://placehold.co/400x400/7c3aed/ffffff?text=Calculator', 15, 1),
('College Laptop Bag', 'Water-resistant laptop bag with multiple compartments. Fits up to 15.6 inch laptops. Padded shoulder straps.', 799.00, 'Accessories', 'https://placehold.co/400x400/059669/ffffff?text=Laptop+Bag', 30, 1),
('Data Structures & Algorithms Notes', 'Hand-written and printed notes bundle covering DSA concepts with solved examples and previous year questions.', 180.00, 'Books', 'https://placehold.co/400x400/dc2626/ffffff?text=DSA+Notes', 50, 1),
('USB-C Hub (7-in-1)', 'Multi-port USB-C hub with HDMI, USB 3.0, SD card reader, and PD charging. Perfect for lab presentations.', 1200.00, 'Electronics', 'https://placehold.co/400x400/ea580c/ffffff?text=USB+Hub', 20, 1),
('Campus Water Bottle (1L)', 'Insulated stainless steel water bottle. Keeps drinks cold for 24h and hot for 12h. BPA-free.', 499.00, 'Accessories', 'https://placehold.co/400x400/0891b2/ffffff?text=Bottle', 40, 1),
('Wireless Earbuds', 'Bluetooth 5.3 earbuds with active noise cancellation. 8-hour battery life. IPX5 water resistant.', 1899.00, 'Electronics', 'https://placehold.co/400x400/6d28d9/ffffff?text=Earbuds', 18, 1),
('Drawing Instrument Set', 'Professional engineering drawing set with compass, divider, protractor, set squares, and mini drafter.', 350.00, 'Stationery', 'https://placehold.co/400x400/be185d/ffffff?text=Drawing+Set', 35, 1),
('Lab Coat (White)', 'Standard white lab coat for chemistry and physics laboratory sessions. Available in multiple sizes.', 299.00, 'Clothing', 'https://placehold.co/400x400/475569/ffffff?text=Lab+Coat', 60, 1),
('Programming in Java (Balagurusamy)', 'Popular Java programming textbook with exercises and case studies. Latest edition.', 520.00, 'Books', 'https://placehold.co/400x400/b91c1c/ffffff?text=Java+Book', 22, 1),
('Portable Desk Lamp (LED)', 'Rechargeable LED desk lamp with adjustable brightness. Eye-care technology. USB-C charging.', 650.00, 'Electronics', 'https://placehold.co/400x400/ca8a04/ffffff?text=Desk+Lamp', 28, 1),
('College ID Card Holder', 'Premium leather ID card holder with lanyard. Space for ID card, bus pass, and library card.', 149.00, 'Accessories', 'https://placehold.co/400x400/16a34a/ffffff?text=ID+Holder', 100, 1);
