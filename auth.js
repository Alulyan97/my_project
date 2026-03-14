const express = require("express");
const bcrypt = require("bcryptjs");
const db = require("../db");
const router = express.Router();

// Регистрация

router.post("/register", async (req, res) => {
  try {
    const { email, password, full_name, city, role } = req.body;

    const emailVerifi = await db.query("SELECT * FROM users WHERE email = $1", [
      email,
    ]);

    if (emailVerifi.rows.length > 0) {
      return res.status(400).json({ error: "Email уже используется" });
    }
    const hash = await bcrypt.hash(password, 7);

    const result = await db.query(
      `INSERT INTO users (email, password_hash, full_name, city, role, trust_level) 
             VALUES ($1, $2, $3, $4, $5, 30) 
             RETURNING id, email, full_name, city, role, trust_level`,
      [email, hash, full_name, city, role],
    );

    res.status(201).json({
      message: "Регистрация успешна",
      user: result.rows[0],
    });
  } catch (e) {
    console.error(err);
    res.status(500).send("error: 'Ошибка сервера'");
  }
});

//Вход

router.post("/login", async (req, res) => {
  try {
    const { email, password } = req.body;

    const emailVerifi = await db.query("SELECT * FROM users WHERE email = $1", [
      email,
    ]);

    const user = emailVerifi.rows[0];

    if (!user) {
      return res.status(400).json({ error: "Неверный email или пароль" });
    }

    const passwordVerifi = await bcrypt.compare(password, user.password_hash);
    if (!passwordVerifi) {
      return res.status(400).json({ error: "Неверный email или пароль" });
    }

    const responseUser = {
      id: user.id,
      email: user.email,
      full_name: user.full_name,
      city: user.city,
      role: user.role,
      trust_level: user.trust_level,
      created_at: user.created_at,
    };

    res.json({
      massage: "Вход выполнен",
      user: responseUser,
    });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: "Ошибка сервера" });
  }
});

module.exports = router;
