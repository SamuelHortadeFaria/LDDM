app.put('/usuario/:id', (req, res) => {
    const { id } = req.params;
    const { nome, idade, email, senha, login, imagem } = req.body;
    const sql = `UPDATE usuarios SET nome = ?, idade = ?, email = ?, senha = ?, login = ?, imagem = ? WHERE id = ?`;
    const params = [nome, idade, email, senha, login, imagem, id];

    db.run(sql, params, function (err) {
        if (err) {
            res.status(400).json({ error: err.message });
            return;
        }
        res.json({ updatedID: id });
    });
});
