-- Создание таблиц
CREATE TABLE users (
    id VARCHAR(80) PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(255)
);

CREATE TABLE posts (
    id VARCHAR(80),
    title VARCHAR(255),
    users_id VARCHAR(80)
);

-- Добавление данных
INSERT INTO users (id, name, email) VALUES 
('u1', 'Иван', 'ivan@mail.com'),
('u2', 'Мария', 'maria@mail.com');

INSERT INTO posts (id, title, users_id) VALUES
('p1', 'Пост Ивана', 'u1'),
('p2', 'Еще пост', 'u1'),
('p3', 'Пост Марии', 'u2');

-- Запросы
SELECT * FROM users
    WHERE id = 'u1';

SELECT * FROM posts 
    ORDER BY id, title;

-- Объединение строк id из двух таблиц
SELECT * FROM users JOIN posts ON users.id = posts.users_id;

-- Группировка результатов (сколько постов у каждого пользователя)
SELECT users_id, COUNT(*) AS posts_count
FROM posts
GROUP BY users_id;

-- Создаем другую таблицу с тимами данних и ограничениями 
CREATE TABLE orders (
    id VARCHAR(80) PRIMARY KEY,
    users_id VARCHAR(80) REFERENCES users(id),
    amount NUMERIC CHECK(amount > 0),
    status VARCHAR DEFAULT 'pending',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    meta JSONB
);

-- Заполняем таблицу orders кривыми данными, чтоб увидеть ошибку 
INSERT INTO orders (id, users_id, amount) VALUES
('o3','u3', -100)