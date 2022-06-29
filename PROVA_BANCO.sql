/* Questão 1 */
CREATE DATABASE estacione_aqui DEFAULT CHARACTER SET utf8;

USE estacione_aqui;

CREATE TABLE cliente (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(60),
    cpf VARCHAR(14),
    data_nascimento date,
);

CREATE TABLE modelo (
	id INT PRIMARY KEY AUTO_INCREMENT,
    descricão VARCHAR(60),
);

CREATE TABLE veiculo (
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    id_modelo INT,
    placa VARCHAR(9),
    cor VARCHAR(20),
    ano YEAR,
    CONSTRAINT fk_veiculo_cliente FOREIGN KEY (id_cliente) REFERENCES,
    CONSTRAINT fk_veiculo_modelo FOREIGN KEY (id_modelo) REFERENCES
);

CREATE TABLE estado (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(60),
    uf VARCHAR(2),
);

CREATE TABLE cidade (
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT,
    nome VARCHAR(60),
    CONSTRAINT fk_cidade_estado FOREIGN KEY (id_estado) REFERENCES estado(id)
);

CREATE TABLE patio (
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_cidade INT,
    logradouro VARCHAR(100),
    numero INT,
    bairro VARCHAR(60),
    CEP VARCHAR (9),
    capacidade INT,
    valor FLOAT (8,2),
    CONSTRAINT fk_patio_cidade FOREIGN KEY (id_cidade) REFERENCES cidade(id)
);

CREATE TABLE ticket(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_veiculo INT,
    id_patio INT,
    data_entrada DATETIME,
    data_saida DATETIME,
    valor FLOAT (8,2),
    CONSTRAINT fk_ticket_veiculo FOREIGN KEY (id_veiculo) REFERENCES veiculo(id),
    CONSTRAINT fk_ticket_patio FOREIGN KEY (id_patio) REFERENCES patio(id)
);

/* Questão 2 */

INSERT INTO cliente(nome) VALUES
('Ana'), ('João'), ('Roger');

INSERT INTO modelo(descricão) VALUES
('Bom estado'), ('nova pintura'), ('motor novo');

INSERT INTO veiculo(cor) VALUES
('Azul'), ('Rosa'), ('Branco');

INSERT INTO ticket(valor) VALUES
('10'), ('5'), ('3');

INSERT INTO patio(bairro) VALUES
('Dom bosco'), ('Fazenda'), ('Limoeiro');

INSERT INTO cidade(nome, estado) VALUES
('Itajaí','Santa Catarina') , ('Brusque','Santa Catarina'), ('Tubarão','Santa Catarina');

INSERT INTO estado (nome,uf) VALUES
('Rio de Janeiro','RJ'), ('Santa Catarina','SC'), ('São Paulo', 'SP');

/* Questão 3 */

UPDATE cliente SET nome = 'Maria', cpf = '897653456', data_nascimento = '01/01/2001' WHERE id = 4;
UPDATE modelo SET descricão = 'Bonito' WHERE id = 1;
UPDATE modelo SET descricão = 'Novo' WHERE id = 7;
UPDATE modelo SET descricão = 'Smart car' WHERE id = 10;
UPDATE veiculo SET placa = 'BRA-2022', cor = 'Preto', ano = '2008' WHERE id = 2;
UPDATE ticket SET data_entrada = '04/09/2022', data_saida = '05/08/2022', valor = '15' WHERE id = 5;
UPDATE patio SET bairro = 'estacionamento' WHERE id = 1 or id = 6 or id = 8;
UPDATE cidade SET nome = 'Cidade Real' WHERE id = 10 or id = 4 or id = 9;

/* Questão 4 */

DELETE FROM cliente WHERE nome = 'Ana';
DELETE FROM modelo WHERE id = b;
DELETE FROM veiculo WHERE cor = 'Branco';
DELETE FROM patio WHERE numero = '1';
DELETE FROM ticket WHERE valor= '10';
DELETE FROM estado WHERE uf = 'SC';
DELETE FROM cidade WHERE nome = 'Itajaí';

/* Questão 5 */

CREATE USER 'FaustoSilveira' IDENTIFIED BY '123456';
GRANT SELECT ON nome, cidade, estado, modelo TO 'FaustoSilveira';
GRANT INSERT, UPDATE, DELETE, SELECT ON ticket, veiculo TO 'FaustoSilveira';
GRANT INSERT, UPDATE, DELETE, ON patio TO 'FaustoSilveira';
REVOKE INSERT, UPDATE ON patio FROM FaustoSilveira;

/* Questão 6 */

SELECT placa, nome FROM veiculo;
SELECT (id_cliente, id_veiculo) FROM ticket INNER JOIN patio p on ticket.id_patio = p.id;
SELECT placa, cor, descricão, ano FROM veiculo INNER JOIN veiculo WHERE ano >= '2010';
SELECT cpf FROM veiculo INNER JOIN ticket t on veiculo.id = t.id_veiculo WHERE descricão = 'hiundai';
SELECT placa, nome FROM veiculo INNER JOIN ticket t on veiculo.id = t.id_veiculo ORDER BY placa;