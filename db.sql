CREATE DATABASE petShopDb;
USE petshop_db;

CREATE TABLE cliente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE pet (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    especie ENUM('cachorro','gato','outro') NOT NULL,
    porte ENUM('pequeno','medio','grande') NOT NULL,
    nascimento DATE,
    FOREIGN KEY (cliente_id) REFERENCES cliente(id)
);


CREATE TABLE servico (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    preco DECIMAL(10,2) NOT NULL CHECK (preco >= 0),
    duracao_min INT NOT NULL CHECK (duracao_min > 0)
);

CREATE TABLE agendamento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pet_id INT NOT NULL,
    servico_id INT NOT NULL,
    data_hora DATETIME NOT NULL,
    status ENUM('agendado','concluido','cancelado') DEFAULT 'agendado',
    observacoes TEXT,
    FOREIGN KEY (pet_id) REFERENCES pet(id),
    FOREIGN KEY (servico_id) REFERENCES servico(id),
    INDEX idx_datahora (data_hora)
);

INSERT INTO cliente (nome, cpf, telefone, email) VALUES
('Flavinho do Pneu', '12345678901', '31999999999', 'flavinh0Tires@gmail.com'),
('shaolin Matador de Porco', '23456789012', '31988888888', 'shaoLinMTporco@gmail.com'),
('Pepe', '34567890123', '31977777777', 'pepe@gmail.com');

INSERT INTO pet (cliente_id, nome, especie, porte, nascimento) VALUES
(1, 'Afonso Paçoca I', 'cachorro', 'grande', '2024-09-01'),
(1, 'Lila', 'gato', 'pequeno', '2020-03-15'),
(2, 'Thor', 'cachorro', 'grande', '2019-08-20');

INSERT INTO servico (nome, preco, duracao_min) VALUES
('Banho', 50.00, 60),
('Tosa', 70.00, 90),
('Vacina', 120.00, 30);

INSERT INTO agendamento (pet_id, servico_id, data_hora, status, observacoes) VALUES
(1, 1, '2025-09-10 10:00:00', 'agendado', 'Cliente prefere banho com shampoo neutro'),
(2, 2, '2025-09-12 14:30:00', 'agendado', NULL),
(3, 3, '2025-09-15 09:00:00', 'agendado', 'Aplicar vacina');
