-- Создание таблиц
CREATE TABLE users (
    id VARCHAR(80),
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