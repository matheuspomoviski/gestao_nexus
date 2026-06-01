CREATE DATABASE gestao_nexus;
use gestao_nexus;

CREATE TABLE usuario (
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
nome VARCHAR(45) NOT NULL,
email VARCHAR(45) NOT NULL,
telefone VARCHAR (11) NOT NULL,
senha VARCHAR(255) NOT NULL,
tipo_acesso ENUM("GERENTE", "GESTOR") NOT NULL,
ativo TINYINT NOT NULL
);

CREATE TABLE setor (
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
nome VARCHAR(45) NOT NULL,
id_responsavel INT,

FOREIGN KEY (id_responsavel) REFERENCES usuario (id)
);

CREATE TABLE fornecedores (
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
nome VARCHAR(45) NOT NULL,
telefone VARCHAR (11) NOT NULL,
CNPJ VARCHAR(14) NOT NULL
);

CREATE TABLE produtos (
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
nome VARCHAR(55) NOT NULL,
id_criado_por INT NOT NULL,
id_fornecedor INT NOT NULL,
id_setor INT NOT NULL,

FOREIGN KEY (id_criado_Por) REFERENCES usuario (id),
FOREIGN KEY (id_fornecedor) REFERENCES fornecedores(id),
FOREIGN KEY (id_setor) REFERENCES setor (id)
);

CREATE TABLE movimentacao (
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
id_produto INT NOT NULL,
id_responsavel INT NOT NULL,
justificativa VARCHAR(200),
data_hora TIMESTAMP,
quantidade_movimentada DECIMAL(10,3),
tipo_movimentacao ENUM("SAIDA", "ENTRADA", "PERDA"),
data_validade DATE,

FOREIGN KEY (id_produto)  REFERENCES produtos(id),
FOREIGN KEY (id_responsavel) REFERENCES usuario(id)
);

CREATE TABLE estoque_atual(
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
quantidade_atual DECIMAL(10,3),
quantidade_minima DECIMAL (10,3),
id_ultima_atualizacao INT,
id_produto INT NOT NULL,

FOREIGN KEY (id_ultima_atualizacao) REFERENCES movimentacao (id),
FOREIGN KEY (id_produto) REFERENCES produtos (id)
);
