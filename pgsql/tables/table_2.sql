-- Создаем таблицу
CREATE TABLE users_1 (
    id VARCHAR (80) PRIMARY KEY,
    name VARCHAR (255),
    email VARCHAR (255) 
);

-- Наполняем случайными данными
INSERT INTO users_1 (id, name, email)
SELECT 
    'user_' || generate_series(101, 10100) AS id,
    'Users_' || generate_series(101, 10100) AS name,
    'user' || generate_series(101, 10100) || '@example.com' AS email;

-- Делаем запрос, для получения определеных данных через EXPLAIN ANALYZE SELECT 

EXPLAIN ANALYZE SELECT * FROM users_1 WHERE 
email = 'user5000@example.com';

-- Создаем индес, для быстрого поискаэ
CREATE INDEX idx_users_email ON users_1(email);

-- Проверяем еще раз скорость обработки по индексу
EXPLAIN ANALYZE SELECT * FROM users_1 WHERE 
email = 'user5000@example.com';