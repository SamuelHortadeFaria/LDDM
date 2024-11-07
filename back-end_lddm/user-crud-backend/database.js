const sqlite3 = require('sqlite3').verbose();

// Abre (ou cria) o banco de dados
const db = new sqlite3.Database('./users.db', (err) => {
    if (err) {
        console.error('Erro ao abrir o banco de dados:', err.message);
    } else {
        console.log('Banco de dados conectado com sucesso.');
    }
});

// Cria a tabela de usuários se não existir
db.serialize(() => {
    db.run(`
        CREATE TABLE IF NOT EXISTS usuarios (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT NOT NULL,
            idade INTEGER,
            email TEXT NOT NULL,
            senha TEXT NOT NULL,
            login TEXT NOT NULL,
            imagem TEXT
        )
    `);
});

module.exports = db;
