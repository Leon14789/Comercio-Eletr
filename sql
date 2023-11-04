CREATE TABLE Produto (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255),
    descricao VARCHAR(255),
    preco INT,
    quantidade_estoque INT
);

CREATE TABLE Pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    data_pedido DATE,
    id_cliente INT,
    id_produto INT,
    quantidade INT,
    status INT,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
);

CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255),
    contato INT,
    endereco_entrega VARCHAR(255)
);

DELIMITER //

CREATE PROCEDURE AdicionarProdutoAoCarrinho(
    IN cliente_id INT,
    IN produto_id INT,
    IN quantidade INT
)
BEGIN
    DECLARE cliente_exist INT;
    DECLARE produto_exist INT;
    SELECT COUNT(*) INTO cliente_exist FROM Cliente WHERE id_cliente = cliente_id;
    SELECT COUNT(*) INTO produto_exist FROM Produto WHERE id_produto = produto_id;
    IF cliente_exist = 1 AND produto_exist = 1 THEN
        INSERT INTO Pedidos (data_pedido, id_cliente, id_produto, quantidade, status)
        VALUES (CURRENT_DATE, cliente_id, produto_id, quantidade, 0);
        SELECT 'Produto adicionado ao carrinho com sucesso.' AS result;
    ELSE
        SELECT 'Cliente ou produto não encontrado.' AS result;
    END IF;
END;
//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE ProcessarPedido(
    IN pedido_id INT
)
BEGIN
    DECLARE pedido_exist INT;
    SELECT COUNT(*) INTO pedido_exist FROM Pedidos WHERE id_pedido = pedido_id;
    IF pedido_exist = 1 THEN
        DECLARE produto_id INT;
        DECLARE quantidade INT;
        SELECT id_produto, quantidade INTO produto_id, quantidade FROM Pedidos WHERE id_pedido = pedido_id;
        DECLARE estoque INT;
        SELECT quantidade_estoque INTO estoque FROM Produto WHERE id_produto = produto_id;
        IF quantidade <= estoque THEN
            UPDATE Produto SET quantidade_estoque = quantidade_estoque - quantidade WHERE id_produto = produto_id;
            UPDATE Pedidos SET status = 1 WHERE id_pedido = pedido_id;
            SELECT 'Pedido processado com sucesso.' AS result;
        ELSE
            SELECT 'Estoque insuficiente.' AS result;
        END IF;
    ELSE
        SELECT 'Pedido não encontrado.' AS result;
    END IF;
END;
//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE CalcularTotalPedido(
    IN pedido_id INT,
    OUT total INT
)
BEGIN
    DECLARE pedido_exist INT;
    SELECT COUNT(*) INTO pedido_exist FROM Pedidos WHERE id_pedido = pedido_id;
    IF pedido_exist = 1 THEN
        DECLARE produto_id INT;
        DECLARE quantidade INT;
        SELECT id_produto, quantidade INTO produto_id, quantidade FROM Pedidos WHERE id_pedido = pedido_id;
        DECLARE preco_produto INT;
        SELECT preco INTO preco_produto FROM Produto WHERE id_produto = produto_id;
        SET total = preco_produto * quantidade;
    ELSE
        SET total = -1;
    END IF;
END;
//

DELIMITER ;
