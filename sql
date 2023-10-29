-- Criação da tabela Produto
create table Produto (
    id_produto int AUTO_INCREMENT PRIMARY KEY,
    nome varchar(255),
    descricao varchar(255),
    preco int,
    quantidade_estoque int
);

-- Criação da tabela Pedidos
create table Pedidos (
    id_pedido int AUTO_INCREMENT PRIMARY KEY,
    data_pedido date,
    id_cliente int,
    id_prod int
    quantidade int,
    status int,
    FOREIGN KEY (id_pedido) REFERENCES Produtos(id_produto)
     FOREIGN KEY (id_pedido) REFERENCES Cliente(id_cliente)
);

-- Criação da tabela Cliente
create table Cliente (
    id_cliente int AUTO_INCREMENT PRIMARY KEY,
    nome varchar(255),
    contato int,
    endereco_entrega varchar(255)
);

-- Stored Procedure para adicionar produtos ao carrinho de compras
create procedure AdicionarProdutoAoCarrinho(
    in cliente_id int,
    in produto_id int,
    in quantidade int
)
begin
    -- EM PROD AQUI FICARIA A LOGICA PARA ADD O PRODUTO AO CARRINHO
end;


-- View que mostra o histórico de pedidos de um cliente específico
create view HistoricoDePedidos as
select
    P.id_pedido,
    P.data_pedido,
    P.id_cliente,
    C.nome as nome_cliente,
    P.id_produto,
    PR.nome as nome_produto,
    P.quantidade,
    P.status
from Pedidos P
join Cliente C on P.id_cliente = C.id_cliente
join Produto PR on P.id_produto = PR.id_produto;

-- View que fornece uma lista de todos os produtos disponíveis (não esgotados)
create view ProdutosDisponiveis as
select * from Produto where quantidade_estoque > 0;

-- Inserção de 20 registros na tabela Produto
INSERT INTO Produto (nome, descricao, preco, quantidade_estoque)
VALUES
    ('Produto 1', 'Descrição do Produto 1', 10, 50),
    ('Produto 2', 'Descrição do Produto 2', 15, 30),
    ('Produto 3', 'Descrição do Produto 3', 20, 40),
    ('Produto 4', 'Descrição do Produto 4', 25, 60),
    ('Produto 5', 'Descrição do Produto 5', 12, 70),
    ('Produto 6', 'Descrição do Produto 6', 18, 45),
    ('Produto 7', 'Descrição do Produto 7', 22, 55),
    ('Produto 8', 'Descrição do Produto 8', 28, 35),
    ('Produto 9', 'Descrição do Produto 9', 30, 20),
    ('Produto 10', 'Descrição do Produto 10', 35, 25),
    ('Produto 11', 'Descrição do Produto 11', 40, 75),
    ('Produto 12', 'Descrição do Produto 12', 45, 80),
    ('Produto 13', 'Descrição do Produto 13', 50, 90),
    ('Produto 14', 'Descrição do Produto 14', 55, 95),
    ('Produto 15', 'Descrição do Produto 15', 60, 100),
    ('Produto 16', 'Descrição do Produto 16', 65, 105),
    ('Produto 17', 'Descrição do Produto 17', 70, 110),
    ('Produto 18', 'Descrição do Produto 18', 75, 115),
    ('Produto 19', 'Descrição do Produto 19', 80, 120),
    ('Produto 20', 'Descrição do Produto 20', 85, 125);

-- Inserção de 20 registros na tabela Cliente
INSERT INTO Cliente (nome, contato, endereco_entrega)
VALUES
    ('Cliente 1', 1234567891, 'Endereço Cliente 1'),
    ('Cliente 2', 1234567892, 'Endereço Cliente 2'),
    ('Cliente 3', 1234567893, 'Endereço Cliente 3'),
    ('Cliente 4', 1234567894, 'Endereço Cliente 4'),
    ('Cliente 5', 1234567895, 'Endereço Cliente 5'),
    ('Cliente 6', 1234567896, 'Endereço Cliente 6'),
    ('Cliente 7', 1234567897, 'Endereço Cliente 7'),
    ('Cliente 8', 1234567898, 'Endereço Cliente 8'),
    ('Cliente 9', 1234567899, 'Endereço Cliente 9'),
    ('Cliente 10', 1234567890, 'Endereço Cliente 10'),
    ('Cliente 11', 1234567801, 'Endereço Cliente 11'),
    ('Cliente 12', 1234567802, 'Endereço Cliente 12'),
    ('Cliente 13', 1234567803, 'Endereço Cliente 13'),
    ('Cliente 14', 1234567804, 'Endereço Cliente 14'),
    ('Cliente 15', 1234567805, 'Endereço Cliente 15'),
    ('Cliente 16', 1234567806, 'Endereço Cliente 16'),
    ('Cliente 17', 1234567807, 'Endereço Cliente 17'),
    ('Cliente 18', 1234567808, 'Endereço Cliente 18'),
    ('Cliente 19', 1234567809, 'Endereço Cliente 19'),
    ('Cliente 20', 1234567810, 'Endereço Cliente 20');


-- Inserção de 20 registros na tabela Pedidos (corrigido)
-- Os pedidos devem corresponder a clientes e produtos existentes na tabela
INSERT INTO Pedidos (data_pedido, id_cliente, id_prod, status)
VALUES
    ('2023-10-29', 1, 1, 0),
    ('2023-10-29', 2, 3, 0),
    ('2023-10-29', 3, 5, 0),
    ('2023-10-29', 4, 7, 0),
    ('2023-10-29', 5, 9, 0),
    ('2023-10-29', 6, 11, 0),
    ('2023-10-29', 7, 13, 0),
    ('2023-10-29', 8, 15, 0),
    ('2023-10-29', 9, 17, 0),
    ('2023-10-29', 10, 19, 0),
    ('2023-10-29', 11, 2, 0),
    ('2023-10-29', 12, 4, 0),
    ('2023-10-29', 13, 6, 0),
    ('2023-10-29', 14, 8, 0),
    ('2023-10-29', 15, 10, 0),
    ('2023-10-29', 16, 12, 0),
    ('2023-10-29', 17, 14, 0),
    ('2023-10-29', 18, 16, 0),
    ('2023-10-29', 19, 18, 0),
    ('2023-10-29', 20, 20, 0);

