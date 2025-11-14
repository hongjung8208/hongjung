const express = require("express");
const mysql = require("mysql2");
const cors = require("cors");

const app = express();
app.use(express.json());
app.use(cors());


const db = mysql.createConnection({
  host: "localhost",
  user: "root",          // MySQL 아이디
  password: "ghdwnd12",  // MySQL 비밀번호
  database: "recipe_db"
});


db.connect(err => {
  if (err) {
    console.log("❌ MySQL 연결 실패:", err);
  } else {
    console.log("✅ MySQL 연결 성공!");
  }
});


app.get("/search", (req, res) => {
  const { ingredient } = req.query;

  if (!ingredient) {
    return res.status(400).send("재료를 입력하세요.");
  }

  
  const items = ingredient.split(" ").filter(v => v.trim() !== "");

  if (items.length === 0) {
    return res.status(400).send("재료를 입력하세요.");
  }


  const likeQuery = items.map(() => "ingredients LIKE ?").join(" AND ");
  const params = items.map(i => `%${i}%`);

  const sql = `
    SELECT recipe_id, recipe_name, ingredients, main_image_url
    FROM Recipes
    WHERE ${likeQuery}
    LIMIT 20
  `;

  db.query(sql, params, (err, results) => {
    if (err) {
      console.error("SQL ERROR:", err);
      return res.status(500).send("DB 검색 실패");
    }
    res.json(results);
  });
});


app.listen(3000, () => {
  console.log("🌐 서버 실행됨: http://localhost:3000");
});
