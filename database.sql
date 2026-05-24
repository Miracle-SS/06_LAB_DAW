CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    names VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(150),
    status BOOLEAN DEFAULT TRUE,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_id INT,
    modified_id INT
);

CREATE TABLE restaurants (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(150),
    phone VARCHAR(20),
    status BOOLEAN DEFAULT TRUE,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_id INT,
    modified_id INT
);

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    status BOOLEAN DEFAULT TRUE,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_id INT,
    modified_id INT
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    restaurant_id INT NOT NULL,
    category_id INT NOT NULL,
    status BOOLEAN DEFAULT TRUE,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_id INT,
    modified_id INT,

    CONSTRAINT fk_products_restaurants
        FOREIGN KEY (restaurant_id)
        REFERENCES restaurants(id),

    CONSTRAINT fk_products_categories
        FOREIGN KEY (category_id)
        REFERENCES categories(id)
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status_order VARCHAR(50),
    status BOOLEAN DEFAULT TRUE,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_id INT,
    modified_id INT,

    CONSTRAINT fk_orders_users
        FOREIGN KEY (user_id)
        REFERENCES users(id)
);

CREATE TABLE order_details (
    id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    status BOOLEAN DEFAULT TRUE,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_id INT,
    modified_id INT,

    CONSTRAINT fk_order_details_orders
        FOREIGN KEY (order_id)
        REFERENCES orders(id),

    CONSTRAINT fk_order_details_products
        FOREIGN KEY (product_id)
        REFERENCES products(id)
);

-- USERS
INSERT INTO users (names, email, phone, address, created_id, modified_id)
VALUES
('Juan Perez', 'juan@gmail.com', '987654321', 'Arequipa', 1, 1),
('Maria Lopez', 'maria@gmail.com', '912345678', 'Cayma', 1, 1);

-- RESTAURANTS
INSERT INTO restaurants (name, address, phone, created_id, modified_id)
VALUES
('Pizza Planet', 'Av. Ejemplo 123', '900111222', 1, 1),
('Burger House', 'Calle Central 456', '933444555', 1, 1);

-- CATEGORIES
INSERT INTO categories (name, description, created_id, modified_id)
VALUES
('Pizzas', 'Variedad de pizzas', 1, 1),
('Hamburguesas', 'Hamburguesas artesanales', 1, 1);

-- PRODUCTS
INSERT INTO products (
    name,
    description,
    price,
    stock,
    restaurant_id,
    category_id,
    created_id,
    modified_id
)
VALUES
('Pizza Americana', 'Pizza con pepperoni', 35.50, 20, 1, 1, 1, 1),
('Hamburguesa Royal', 'Hamburguesa doble carne', 22.90, 15, 2, 2, 1, 1);

-- ORDERS
INSERT INTO orders (
    user_id,
    total,
    status_order,
    created_id,
    modified_id
)
VALUES
(1, 58.40, 'Pendiente', 1, 1);

-- ORDER DETAILS
INSERT INTO order_details (
    order_id,
    product_id,
    quantity,
    price,
    subtotal,
    created_id,
    modified_id
)
VALUES
(1, 1, 1, 35.50, 35.50, 1, 1),
(1, 2, 1, 22.90, 22.90, 1, 1);

SELECT * FROM users;

SELECT 
    orders.id AS order_id,
    users.names AS customer,
    products.name AS product,
    order_details.quantity,
    order_details.subtotal
FROM order_details
JOIN orders ON order_details.order_id = orders.id
JOIN users ON orders.user_id = users.id
JOIN products ON order_details.product_id = products.id;
