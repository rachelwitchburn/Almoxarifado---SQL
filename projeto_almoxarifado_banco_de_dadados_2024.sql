create database almoxarifado;

use almoxarifado;

CREATE TABLE Almoxarifado (
	idAlmoxarifado INT,
	nome VARCHAR(50) NOT NULL,
	CONSTRAINT PKAlmoxarifado PRIMARY KEY (idAlmoxarifado)
);

CREATE TABLE Endereco (
	idEndereco INT AUTO_INCREMENT,
	cep CHAR(9) NOT NULL,
	bairro VARCHAR(60) NOT NULL,
	logradouro VARCHAR(255) NOT NULL,
	cidade VARCHAR (40) NOT NULL,
	numero VARCHAR(10) NOT NULL,
	complemento VARCHAR(255),
	CONSTRAINT PKEndereco PRIMARY KEY (idEndereco)
);

CREATE TABLE Cliente (
	CGC VARCHAR (18),
	idAlmoxarifado INT,
	idEndereco INT,
	nome VARCHAR(50) NOT NULL,
CONSTRAINT PKCliente PRIMARY KEY (CGC),
CONSTRAINT FKClienteAlmoxarifado FOREIGN KEY (idAlmoxarifado) REFERENCES Almoxarifado(idAlmoxarifado),
CONSTRAINT FKClienteEndereco FOREIGN KEY (idEndereco) REFERENCES Endereco(idEndereco)
	);

CREATE TABLE TelefoneCliente (
	idTelefone INT AUTO_INCREMENT,
	CGC VARCHAR(18),
	telefone VARCHAR (20) NOT NULL,
	CONSTRAINT FKTelefoneCliente FOREIGN KEY (CGC) REFERENCES Cliente(CGC),
	CONSTRAINT PKTelefoneCliente PRIMARY KEY (idTelefone)
);

CREATE TABLE Corredor (
	numCorredor VARCHAR (10),
	idAlmoxarifado INT,
	CONSTRAINT FKCorredorAlmoxarifado FOREIGN KEY (idAlmoxarifado) REFERENCES Almoxarifado(idAlmoxarifado),
	CONSTRAINT PKCorredor PRIMARY KEY (numCorredor)
);

CREATE TABLE Estrado (
	idEstrado INT AUTO_INCREMENT,
	numCorredor VARCHAR (10),
	CONSTRAINT FKEstradoCorredor FOREIGN KEY (numCorredor) REFERENCES Corredor(numCorredor),
	CONSTRAINT PKEstrado PRIMARY KEY (idEstrado)
);

CREATE TABLE Categoria_da_Peca (
	idCategoria INT AUTO_INCREMENT,
	nome VARCHAR(50) NOT NULL,
	CONSTRAINT PKCategoriaPeca PRIMARY KEY (idCategoria)
);

CREATE TABLE Ordem_de_Compra (
	idOrdemCompra INT AUTO_INCREMENT,
	dataChegada DATE NOT NULL,
	CONSTRAINT PKOrdemCompra PRIMARY KEY (idOrdemCompra)
);


CREATE TABLE Entrega (
	idEntrega INT AUTO_INCREMENT,
	idOrdemCompra INT,
	dataEntrega DATE,
	quantidade INT NOT NULL,
	CONSTRAINT FKOrdemCompra FOREIGN KEY (idOrdemCompra) REFERENCES Ordem_de_Compra (idOrdemCompra),
	CONSTRAINT PKEntrega PRIMARY KEY (idEntrega)
);

CREATE TABLE Pedido (
	idPedido INT AUTO_INCREMENT,
	CGC VARCHAR (18),
	preco DECIMAL(10, 2),
	CONSTRAINT FKPedidoCliente FOREIGN KEY (CGC) REFERENCES Cliente(CGC),
	CONSTRAINT PKPedido PRIMARY KEY (idPedido)
);

CREATE TABLE Peca (
	UPC INT AUTO_INCREMENT,
	idCategoria INT,
	idPedido INT,
	idEntrega INT NOT NULL,
	estocada BOOLEAN,
	numeroInterno INT NOT NULL,
	descricao VARCHAR(255) NOT NULL,
	CONSTRAINT FKPecaCategoria FOREIGN KEY (idCategoria) REFERENCES Categoria_da_Peca(idCategoria),
	CONSTRAINT FKPedido FOREIGN KEY (idPedido) REFERENCES Pedido (idPedido),
	CONSTRAINT PKPeca PRIMARY KEY (UPC),
	CONSTRAINT FKEntrega FOREIGN KEY (idEntrega) REFERENCES Entrega(idEntrega)
);


CREATE TABLE Lista_de_Busca (
	idListaBusca INT AUTO_INCREMENT,
	idPedido INT,
CONSTRAINT FKListaBuscaPedido FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido),
	CONSTRAINT PKListaBusca PRIMARY KEY (idListaBusca)
);

CREATE TABLE Receptaculo (
	idReceptaculo INT AUTO_INCREMENT,
	idEstrado INT,
	idCategoria INT,
	estaCheio BOOLEAN,
	estaVazio BOOLEAN,
quantidadePeca INT,
CONSTRAINT FKReceptaculoEstrado FOREIGN KEY (idEstrado) REFERENCES Estrado(idEstrado),
CONSTRAINT FKReceptaculoCategoria FOREIGN KEY (idCategoria) REFERENCES Categoria_da_Peca(idCategoria),
	CONSTRAINT PKReceptaculo PRIMARY KEY (idReceptaculo)
);


CREATE TABLE Lista_de_Distribuicao(
	idListaDistrib INT AUTO_INCREMENT,
	idEntrega INT,
CONSTRAINT FKListaDistribuicaoEntrega FOREIGN KEY (idEntrega) REFERENCES Entrega(idEntrega),
	CONSTRAINT PKListaDistribuicao PRIMARY KEY (idListaDistrib)
);




USE almoxarifado;

-- Dados para a tabela Almoxarifado
INSERT INTO Almoxarifado (idAlmoxarifado, nome) VALUES
(1, 'Regional'),
(2, 'Sunrise'),
(3, 'Silveira'),
(4, 'BR Guardian');

-- Dados para a tabela Endereco
INSERT INTO Endereco (idEndereco, cep, bairro, logradouro, cidade, numero, complemento) VALUES
(1, '12345-678', 'Centro', 'Rua A', 'São Paulo', '100', 'Prédio A'),
(2, '87654-321', 'Zona Norte', 'Avenida B', 'São Paulo', '200', NULL),
(3, '73283-123', 'Floral', 'Avenida nortista', 'Rio de Janeiro', '807A', 'bloco C'),
(4, '63274-421', 'Centro', 'Rua João Pereira', 'Sousa', '6', NULL),
(5, '21231-212', 'Catolé', 'Rua Coronel Silveira', 'Campina Grande', '999', NULL);

-- Dados para a tabela Cliente
INSERT INTO Cliente (CGC, idAlmoxarifado, idEndereco, nome) VALUES
('12.345.678/0001-99', 1, 1, 'SAP'),
('98.765.432/0001-88', 2, 2, 'Oracle'),
('62.342.896/0001-67', 3, 3, 'Bandeirantes'),
('47.283.993/0002-75', 4, 4, 'X Olimpum');


-- Dados para a tabela TelefoneCliente
INSERT INTO TelefoneCliente (idTelefone, CGC, telefone) VALUES
(1, '12.345.678/0001-99', '(11) 99999-1111'),
(2, '98.765.432/0001-88', '(11) 88888-2222'),
(3, '47.283.993/0002-75', '(83) 2323-2323');

-- Dados para a tabela Corredor
INSERT INTO Corredor (numCorredor, idAlmoxarifado) VALUES
('C01', 1),
('C1', 2),
('C02', 1),
('C03', 1),
('C04', 1),
('C05', 1),
('C2', 2),
('C3', 3);

-- Dados para a tabela Estrado
INSERT INTO Estrado (idEstrado, numCorredor) VALUES
(1, 'C01'),
(2, 'C02'),
(3, 'C2'),
(4, 'C03'),
(5, 'C05'),
(6, 'C3');

-- Dados para a tabela Categoria_da_Peca
INSERT INTO Categoria_da_Peca (idCategoria, nome) VALUES
(1, 'Eletrônicos'),
(2, 'Ferramentas'),
(3, 'Suportes'),
(4, 'Suplementos');

-- Dados para a tabela Ordem_de_Compra
INSERT INTO Ordem_de_Compra (idOrdemCompra, dataChegada) VALUES
(1, '2024-11-01'),
(2, '2024-11-10'),
(3, '2024-11-19'),
(4, '2024-10-24'),
(5, '2024-10-04'),
(6, '2024-11-05'), 
(7, '2024-11-25');

-- Dados para a tabela Entrega
INSERT INTO Entrega (idEntrega, idOrdemCompra, dataEntrega, quantidade) VALUES
(1, 1, '2024-11-05', 50),
(2, 2, '2024-11-15', 120),
(3, 1, '2024-11-20', 75),
(4, 2, '2024-12-01', 150),
(5, 1, '2024-12-10', 30),
(6, 2, '2024-12-15', 200),
(7, 6, '2024-11-10', 50), -- Parcialmente entregue
(8, 7, '2024-11-29', 30), -- Outra entrega dentro do intervalo
(9, 3, '2024-12-01', 50), -- Entrega futura (fora do intervalo)
(10, 3, '2024-11-29', 30); -- Entrega válida dentro do intervalo


-- Dados para a tabela Pedido
INSERT INTO Pedido (idPedido, CGC, preco) VALUES
(1, '12.345.678/0001-99', 1000.50),
(2, '98.765.432/0001-88', 500.00),
(3, '12.345.678/0001-99', 750.00),
(4, '98.765.432/0001-88', 1200.00),
(5, '12.345.678/0001-99', 400.00),
(6, '98.765.432/0001-88', 950.50),
(9, '12.345.678/0001-99', 850.00),
(10, '98.765.432/0001-88', 1200.00),
(11, '12.345.678/0001-99', 1300.00),
(12, '98.765.432/0001-88', 1450.00);


-- Dados para a tabela Peca
INSERT INTO Peca (UPC, idCategoria, idPedido, idEntrega, estocada, numeroInterno, descricao) VALUES
(1, 1, 1, 1, TRUE, 101, 'Notebook Dell Inspiron'),
(2, 2, 2, 2, TRUE, 102, 'Parafusadeira Bosch'),
(3, 1, 3, 3, TRUE, 103, 'Monitor LG UltraWide'),
(4, 2, 4, 4, TRUE, 104, 'Furadeira Makita'),
(5, 3, 5, 5, FALSE, 105, 'Suporte para TV 40-60 polegadas'),
(6, 1, 6, 6, TRUE, 106, 'Teclado Mecânico Logitech'),
(7, 3, 3, 4, FALSE, 107, 'Cadeira de Escritório Ergonômica'),
(8, 2, 4, 5, TRUE, 108, 'Kit de Chaves de Fenda Stanley'),
(11, 1, 9, 5, FALSE, 111, 'Scanner Brother DCP-L2550DW'),
(12, 2, 9, 7, FALSE, 112, 'Aspirador Dyson V15'),
(13, 3, 10, 7, TRUE, 113, 'Estante de Madeira 4 Prateleiras'),
(14, 4, 10, 6, FALSE, 114, 'Notebook Apple MacBook Pro 16'),
(15, 2, 9, 4, TRUE, 115, 'Conjunto de Ferramentas Bosch'),
(16, 2, 9, 9, FALSE, 116, 'Mesa de Escritório Modulada'),
(17, 3, 10, 10, TRUE, 117, 'Cadeira Gamer HyperX'),
(18, 4, 9, 9, FALSE, 118, 'Kit de Rodízios para Móveis'),
(19, 1, 10, 10, TRUE, 119, 'Smartphone Samsung Galaxy S23'),
(20, 1, 11, 9, FALSE, 120, 'Monitor Samsung Curvo 27'),
(21, 2, 12, 10, TRUE, 121, 'Caixa de Som JBL Charge 5');



-- Dados para a tabela Lista_de_Busca
INSERT INTO Lista_de_Busca (idListaBusca, idPedido) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6);

-- Dados para a tabela Receptaculo
INSERT INTO Receptaculo (idReceptaculo, idEstrado, idCategoria, estaCheio, estaVazio, quantidadePeca) VALUES
(1, 1, 1, FALSE, TRUE, 20),
(2, 2, 2, TRUE, FALSE, 120),
(3, 1, 2, TRUE, FALSE, 60),
(4, 2, 1, FALSE, TRUE, 10),
(5, 1, 3, TRUE, FALSE, 90),
(6, 2, 3, FALSE, TRUE, 5);

-- Dados para a tabela Lista_de_Distribuicao
INSERT INTO Lista_de_Distribuicao (idListaDistrib, idEntrega) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6);



-- 1
SELECT DISTINCT Corredor.numCorredor
FROM Corredor
JOIN Estrado ON Estrado.numCorredor = Corredor.numCorredor
JOIN Receptaculo ON Receptaculo.idEstrado = Estrado.idEstrado
JOIN Peca ON Peca.idCategoria = Receptaculo.idCategoria
JOIN Pedido ON Pedido.idPedido = Peca.idPedido
JOIN Cliente ON Cliente.CGC = Pedido.CGC
WHERE Cliente.nome = 'SAP';


-- 2
SELECT Peca.UPC, Peca.descricao, Receptaculo.quantidadePeca
FROM Peca
JOIN Receptaculo ON Peca.idCategoria = Receptaculo.idCategoria
WHERE Receptaculo.quantidadePeca < 100;


-- 3
SELECT Receptaculo.idReceptaculo, Receptaculo.quantidadePeca
FROM Receptaculo;

-- 4
SELECT Cliente.nome, SUM(Receptaculo.quantidadePeca) AS total_pecas
FROM Cliente
JOIN Pedido ON Cliente.CGC = Pedido.CGC
JOIN Peca ON Pedido.idPedido = Peca.idPedido
JOIN Receptaculo ON Peca.idCategoria = Receptaculo.idCategoria
GROUP BY Cliente.nome
ORDER BY total_pecas DESC
LIMIT 10;


-- 5
SELECT Cliente.nome, COUNT(Pedido.idPedido) AS total_pedidos
FROM Cliente
JOIN Pedido ON Cliente.CGC = Pedido.CGC
GROUP BY Cliente.nome
ORDER BY total_pedidos DESC
LIMIT 10;

-- 6
DELIMITER //
CREATE PROCEDURE listar_pedidos_cliente(IN clienteCGC VARCHAR(18))
BEGIN
    SELECT Pedido.idPedido, Pedido.preco, 
           CASE 
               WHEN Entrega.idEntrega IS NOT NULL THEN 'ENTREGUE' 
               ELSE 'NÃO ENTREGUE' 
           END AS status
    FROM Pedido
    LEFT JOIN Peca ON Pedido.idPedido = Peca.idPedido
    LEFT JOIN Entrega ON Peca.idEntrega = Entrega.idEntrega
    WHERE Pedido.CGC = clienteCGC;
END;
//
DELIMITER ;
CALL listar_pedidos_cliente('12.345.678/0001-99');




-- 7
DELIMITER //
CREATE PROCEDURE produtos_mais_pedidos(IN data_inicio DATE, IN data_fim DATE)
BEGIN
    SELECT Peca.descricao, COUNT(Peca.UPC) AS total_pedidos
    FROM Peca
    JOIN Pedido ON Peca.idPedido = Pedido.idPedido
    JOIN Ordem_de_Compra ON Ordem_de_Compra.idOrdemCompra = Peca.idEntrega
    WHERE Ordem_de_Compra.dataChegada BETWEEN data_inicio AND data_fim
    GROUP BY Peca.descricao
    ORDER BY total_pedidos DESC
    LIMIT 5;
END;
//
DELIMITER ;
CALL produtos_mais_pedidos('2024-11-01', '2024-11-30');


-- 8
DELIMITER //
CREATE PROCEDURE produtos_nao_entregues(
	IN data_inicio DATE, 
	IN data_fim DATE
)
BEGIN
    SELECT 
        p.UPC AS codigo_produto,
        p.descricao AS descricao_produto,
        pd.CGC AS cliente,
        o.dataChegada AS data_pedido
    FROM 
        Peca p
    JOIN 
        Pedido pd ON p.idPedido = pd.idPedido
    JOIN 
        Ordem_de_Compra o ON p.idEntrega = o.idOrdemCompra
    WHERE 
        o.dataChegada BETWEEN data_inicio AND data_fim
        AND p.estocada = FALSE;
END;
//

DELIMITER ;

-- DROP PROCEDURE IF EXISTS produtos_nao_entregues;

CALL produtos_nao_entregues('2024-11-01', '2024-11-30');


