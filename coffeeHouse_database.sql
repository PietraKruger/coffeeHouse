CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    senha VARCHAR(255) NOT NULL
);

CREATE TABLE produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    tempo_preparo INTEGER NOT NULL,
    emoji VARCHAR(50)
);

CREATE TABLE avaliacoes (
    id SERIAL PRIMARY KEY,
    produto_id INTEGER NOT NULL,
    nota INTEGER NOT NULL,
    comentario TEXT,
    data_avaliacao TIMESTAMP NOT NULL
);

CREATE TABLE pedidos (
    id SERIAL PRIMARY KEY,
    produto_id INTEGER NOT NULL,
    quantidade INTEGER NOT NULL,
    data_pedido TIMESTAMP NOT NULL
);

INSERT INTO usuarios (id, nome, senha) VALUES 
(1, 'admin', '123456'),
(2, 'daniel', '123456');

INSERT INTO produtos (id, nome, categoria, preco, tempo_preparo, emoji) VALUES 
(1, 'Cappuccino', 'cafe', 12.00, 5, NULL),
(2, 'Café Expresso', 'cafe', 8.00, 3, NULL),
(3, 'Mocha', 'cafe', 15.00, 6, NULL),
(4, 'Croissant', 'lanches', 14.00, 4, NULL),
(5, 'Pão de Queijo', 'lanches', 9.00, 3, NULL),
(6, 'Sanduiche Natural', 'lanches', 18.00, 7, NULL),
(7, 'Bolo de Chocolate', 'sobremesas', 10.00, 3, NULL),
(8, 'Cheesecake', 'sobremesas', 16.00, 4, NULL),
(9, 'Brownie', 'sobremesas', 11.00, 3, NULL);

INSERT INTO avaliacoes (id, produto_id, nota, comentario, data_avaliacao) VALUES
(2, 1, 4, 'otimo café', '2026-04-26 13:07:26'),
(3, 2, 5, 'delicia', '2026-04-26 13:07:53'),
(4, 7, 4, 'muito bom', '2026-04-26 13:25:36'),
(5, 8, 2, 'exelente!!', '2026-04-26 13:26:23'),
(6, 1, 4, 'dsAXax', '2026-04-27 07:54:00'),
(7, 1, 3, 'wdadawd', '2026-04-27 10:18:50'),
(8, 7, 2, 'scascsc', '2026-04-27 12:47:39');


INSERT INTO pedidos (id, produto_id, quantidade, data_pedido) VALUES 
(25, 8, 1, '2026-04-27 12:47:44');

ALTER TABLE avaliacoes 
ADD CONSTRAINT fk_avaliacoes_produtos 
FOREIGN KEY (produto_id) REFERENCES produtos(id) ON DELETE CASCADE;

ALTER TABLE pedidos 
ADD CONSTRAINT fk_pedidos_produtos 
FOREIGN KEY (produto_id) REFERENCES produtos(id) ON DELETE CASCADE;

SELECT setval(pg_get_serial_sequence('usuarios', 'id'), COALESCE(MAX(id), 1)) FROM usuarios;
SELECT setval(pg_get_serial_sequence('produtos', 'id'), COALESCE(MAX(id), 1)) FROM produtos;
SELECT setval(pg_get_serial_sequence('avaliacoes', 'id'), COALESCE(MAX(id), 1)) FROM avaliacoes;
SELECT setval(pg_get_serial_sequence('pedidos', 'id'), COALESCE(MAX(id), 1)) FROM pedidos;

---TESTE---
SELECT 
    p.id AS pedido_id, 
    prod.nome AS nome_produto, 
    p.quantidade, 
    p.data_pedido
FROM pedidos p
INNER JOIN produtos prod ON p.produto_id = prod.id;